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

  end
end

