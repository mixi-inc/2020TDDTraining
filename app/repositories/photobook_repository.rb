class PhotobookRepository
  def initialize(photobook_model:, photobook_page_model:)
    @photobook = photobook_model
    @photobook_page = photobook_page_model
  end

  def create(
    album_id:,
    account_id:,
    cover_media_id:,
    cover_media_taken_at:,
    title:,
    subtitle:,
    photobook_pages:
  )
    photobook = @photobook.create(
      album_id: album_id,
      account_id: account_id,
      cover_media_id: cover_media_id,
      cover_media_taken_at: cover_media_taken_at,
      title: title,
      subtitle: subtitle
    )
    pages = photobook_pages.map do |new_page|
      PhotobookPage.create(
        photobook_id: photobook.id,
        page_number: new_page[:page_number],
        media_id: new_page[:media_id],
        comment: new_page[:comment]
      )
    end
    PhotobookEntity.new(
      id: photobook.id,
      album_id: photobook.album_id,
      account_id: photobook.account_id,
      cover_media_id: photobook.cover_media_id,
      cover_media_taken_at: photobook.cover_media_taken_at,
      title: photobook.title,
      subtitle: photobook.subtitle,
      photobook_pages: pages.map do |page|
        PhotobookPageEntity.new(
          id: page.id,
          photobook_id: page.photobook_id,
          page_number: page.page_number,
          media_id: page.media_id,
          comment: page.comment
        )
      end
    )
  end
end
