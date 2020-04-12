class PhotobookEntity
  attr_accessor :id, :album_id, :account_id, :cover_media_id, :cover_media_taken_at, :title, :subtitle, :photobook_pages

  def initialize(
    id:,
    album_id:,
    account_id:,
    cover_media_id:,
    cover_media_taken_at:,
    title:,
    subtitle:,
    photobook_pages:
  )
    @id = id
    @album_id = album_id
    @account_id = account_id
    @cover_media_id = cover_media_id
    @cover_media_taken_at = cover_media_taken_at
    @title = title
    @subtitle = subtitle
    @photobook_pages = photobook_pages
  end
end
