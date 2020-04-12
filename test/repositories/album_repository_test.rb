require 'test_helper'

class AlbumRepositoryTest < ActiveSupport::TestCase
  test 'should return AlbumEntity' do
    repository = AlbumRepository.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: '太郎', birthday: Time.zone.parse('2019/01/01')),
        MockChild.new(name: '次郎', birthday: Time.zone.parse('2020/01/01'))
      ])
    )
    album = repository.find_by(id: 0)
    assert(album.is_a?(AlbumEntity))
    assert_equal(2, album.children.count)
  end
end

class MockAlbum
  attr_accessor :id, :children

  def initialize(id: nil, children:)
    @children = children
  end

  def find_by(id:)
    MockAlbum.new(id: id, children: @children)
  end
end

class MockChild
  attr_accessor :id, :name, :birthday

  def initialize(id: nil, name:, birthday:)
    @id = id
    @name = name
    @birthday = birthday
  end
end
