module Api
  module V1
    module Albums
      class PhotobooksController < ApplicationController
        def create
          album = Album.find_by(id: params[:album_id])
          if album.nil?
            return render json: {
              code: 'album_not_found',
              message: 'アルバムが存在していません'
            }, status: 404
          end

          if params[:title].present? && params[:title].length > 20
            return render json: {
              code: 'too_long_photobook_title',
              message: 'フォトブックのタイトルが文字数上限を超えています'
            }, status: 400
          end

          if params[:subtitle].present? && params[:subtitle].length > 20
            return render json: {
              code: 'too_long_photobook_subtitle',
              message: 'フォトブックのサブタイトルが文字数上限を超えています'
            }, status: 400
          end

          if params[:photobook_pages].any? { |page| (page[:comment] || '').length > 200 }
            return render json: {
              code: 'too_long_photobook_comment',
              message: 'フォトブックのコメントが文字数上限を超えています'
            }, status: 400
          end

          taken_date = Time.zone.parse(params[:cover_media_taken_at])
          title = params[:title] || "#{taken_date.year}年#{taken_date.month}月のアルバム"

          subtitle = params[:subtitle] || album.children.map do |extract_child|
            age = lunar_age(extract_child, at: taken_date)
            extract_child.name + (age || '')
          end.join('・')
          subtitle = subtitle.length > 20 ? 'Family Album' : subtitle

          photobook = Photobook.create(
            album_id: params[:album_id],
            account_id: params[:account_id],
            cover_media_id: params[:cover_media_id],
            cover_media_taken_at: params[:cover_media_taken_at],
            title: title,
            subtitle: subtitle
          )

          pages = params[:photobook_pages].map do |new_page|
            PhotobookPage.create(
              photobook_id: photobook.id,
              page_number: new_page[:page_number],
              media_id: new_page[:media_id],
              comment: new_page[:comment]
            )
          end

          render json: {
            id: photobook.id,
            title: photobook.title,
            subtitle: photobook.subtitle
          }, status: 201
        end

        def lunar_age(child, at: Time.zone.now)
          return '' if child.birthday > at.to_date

          years, months = calc_year_month(child, at)
          "#{years}歳#{months}ヶ月"
        end

        def calc_year_month(child, at) 
          return if child.birthday.blank?

          years = (at.strftime('%Y%m').to_i - child.birthday.strftime('%Y%m').to_i) / 100
          months = at.month.to_i - child.birthday.month.to_i
          months += 12 if months.negative?
          [years, months]
        end
      end
    end
  end
end
