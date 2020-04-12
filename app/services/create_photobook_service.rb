class CreatePhotobookService
  class AlbumNotFoundError < StandardError; end
  class TitleTooLongError < StandardError; end
  class SubtitleTooLongError < StandardError; end
  class CommentTooLongError < StandardError; end

  TITLE_MAX_LENGTH = 20
  SUBTITLE_MAX_LENGTH = 20
  COMMENT_MAX_LENGTH = 200

  def call(
    album_id:,
    account_id:,
    title:,
    subtitle:, 
    cover_media_id:,
    cover_media_taken_at:,
    photobook_pages:
  )
    album = Album.find_by(id: album_id)
    raise AlbumNotFoundError if album.nil?

    raise TitleTooLongError if title.present? && title.length > TITLE_MAX_LENGTH

    raise SubtitleTooLongError if subtitle.present? && subtitle.length > SUBTITLE_MAX_LENGTH

    raise CommentTooLongError if photobook_pages.any? { |page| (page[:comment] || '').length > COMMENT_MAX_LENGTH }

    taken_date = Time.zone.parse(cover_media_taken_at)
    title ||= "#{taken_date.year}年#{taken_date.month}月のアルバム"

    subtitle ||= album.children.map do |extract_child|
      age = lunar_age(extract_child, at: taken_date)
      extract_child.name + (age || '')
    end.join('・')
    subtitle = subtitle.length > SUBTITLE_MAX_LENGTH ? 'Family Album' : subtitle

    photobook = Photobook.create(
      album_id: album_id,
      account_id: account_id,
      cover_media_id: cover_media_id,
      cover_media_taken_at: cover_media_taken_at,
      title: title,
      subtitle: subtitle
    )

    photobook_pages.map do |new_page|
      PhotobookPage.create(
        photobook_id: photobook.id,
        page_number: new_page[:page_number],
        media_id: new_page[:media_id],
        comment: new_page[:comment]
      )
    end

    photobook
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
