module Api
  module V1
    module Albums
      class PhotobooksController < ApplicationController
        def create
          begin
            service = CreatePhotobookService.new(
              album_model: Album,
              photobook_model: Photobook,
              photobook_page_model: PhotobookPage
            )
            photobook = service.call(
              album_id: params[:album_id],
              account_id: params[:account_id],
              title: params[:title],
              subtitle: params[:subtitle],
              cover_media_id: params[:cover_media_id],
              cover_media_taken_at: params[:cover_media_taken_at],
              photobook_pages: params[:photobook_pages]
            )
          rescue CreatePhotobookService::AlbumNotFoundError
            return render json: {
              code: 'album_not_found',
              message: 'アルバムが存在していません'
            }, status: 404
          rescue CreatePhotobookService::TitleTooLongError
            return render json: {
              code: 'too_long_photobook_title',
              message: 'フォトブックのタイトルが文字数上限を超えています'
            }, status: 400
          rescue CreatePhotobookService::SubtitleTooLongError
            return render json: {
              code: 'too_long_photobook_subtitle',
              message: 'フォトブックのサブタイトルが文字数上限を超えています'
            }, status: 400
          rescue CreatePhotobookService::CommentTooLongError
            return render json: {
              code: 'too_long_photobook_comment',
              message: 'フォトブックのコメントが文字数上限を超えています'
            }, status: 400
          end

          render json: {
            id: photobook.id,
            title: photobook.title,
            subtitle: photobook.subtitle
          }, status: 201
        end
      end
    end
  end
end
