class PhotobookPageEntity
  attr_accessor :id, :photobook_id, :page_number, :media_id, :comment
  
  def initialize(
    id:,
    photobook_id:,
    page_number:,
    media_id:,
    comment:
  )
    @id = id
    @photobook_id = photobook_id
    @page_number = page_number
    @media_id = media_id
    @comment = comment
  end
end
