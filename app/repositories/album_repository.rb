class AlbumRepository
  def initialize(album_model:)
    @album = album_model
  end

  def find_by(id:)
    album = @album.find_by(id: id)
    AlbumEntity.new(
      id: album.id,
      children: album.children.map do |child|
        ChildEntity.new(
          id: child.id,
          name: child.name,
          birthday: child.birthday
        )
      end
    )
  end
end
