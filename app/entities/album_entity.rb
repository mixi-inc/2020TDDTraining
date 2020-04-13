class AlbumEntity
  attr_accessor :id, :children

  def initialize(id:, children:)
    @id = id
    @children = children
  end
end
