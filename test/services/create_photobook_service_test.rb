require 'test_helper'

class CreatePhotobookServiceTest < ActiveSupport::TestCase
  test 'should create photobook and photobook pages' do
    service = CreatePhotobookService.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: '太郎', birthday: Time.zone.parse('2019/01/01')),
        MockChild.new(name: '次郎', birthday: Time.zone.parse('2020/01/01'))
      ]),
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    photobook = service.call(
      album_id: 0,
      account_id: 0,
      title: nil,
      subtitle: nil, 
      cover_media_id: 0,
      cover_media_taken_at: '2020/04/01',
      photobook_pages: [
        { 
          page_number: 1,
          media_id: 1,
          comment: 'いいね'
        }, {
          page_number: 2,
          media_id: 2,
          comment: 'いいよ'
        }
      ]
    )
    assert_equal('2020年4月のアルバム', photobook.title)
    assert_equal('太郎1歳3ヶ月・次郎0歳3ヶ月', photobook.subtitle)
  end

  test 'should be default subtitle when formatted subtitle is over limit length' do
    service = CreatePhotobookService.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: 'A' * (CreatePhotobookService::SUBTITLE_MAX_LENGTH + 1), birthday: Time.zone.parse('2019/01/01'))
      ]),
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    photobook = service.call(
      album_id: 0,
      account_id: 0,
      title: nil,
      subtitle: nil, 
      cover_media_id: 0,
      cover_media_taken_at: '2020/04/01',
      photobook_pages: []
    )
    assert_equal('Family Album', photobook.subtitle)
  end

  test 'should use given title and subtitle if not empty' do
    service = CreatePhotobookService.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: '太郎', birthday: Time.zone.parse('2019/01/01'))
      ]),
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    photobook = service.call(
      album_id: 0,
      account_id: 0,
      title: 'タイトル',
      subtitle: 'サブタイトル', 
      cover_media_id: 0,
      cover_media_taken_at: '2020/04/01',
      photobook_pages: []
    )
    assert_equal('タイトル', photobook.title)
    assert_equal('サブタイトル', photobook.subtitle)
  end

  test 'should not add age into subtitle if the child is not born yet' do
    service = CreatePhotobookService.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: '太郎', birthday: Time.zone.parse('2019/01/01'))
      ]),
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    photobook = service.call(
      album_id: 0,
      account_id: 0,
      title: nil,
      subtitle: nil, 
      cover_media_id: 0,
      cover_media_taken_at: '2018/04/01',
      photobook_pages: []
    )
    assert_equal('太郎', photobook.subtitle)
  end

  test 'should raise AlbumNotFoundError when album is not found' do
    service = CreatePhotobookService.new(
      album_model: MockEmptyAlbum.new,
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    assert_raise(CreatePhotobookService::AlbumNotFoundError) {
      service.call(
        album_id: 0,
        account_id: 0,
        title: nil,
        subtitle: nil, 
        cover_media_id: 0,
        cover_media_taken_at: '2018/04/01',
        photobook_pages: []
      )
    }
  end

  test 'should raise TitleTooLongError when title is too long' do
    service = CreatePhotobookService.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: '太郎', birthday: Time.zone.parse('2019/01/01'))
      ]),
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    assert_raise(CreatePhotobookService::TitleTooLongError) {
      service.call(
        album_id: 0,
        account_id: 0,
        title: 'A' * (CreatePhotobookService::TITLE_MAX_LENGTH + 1),
        subtitle: nil, 
        cover_media_id: 0,
        cover_media_taken_at: '2018/04/01',
        photobook_pages: []
      )
    }
  end

  test 'should raise SubtitleTooLongError when subtitle is too long' do
    service = CreatePhotobookService.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: '太郎', birthday: Time.zone.parse('2019/01/01'))
      ]),
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    assert_raise(CreatePhotobookService::SubtitleTooLongError) {
      service.call(
        album_id: 0,
        account_id: 0,
        title: nil,
        subtitle: 'A' * (CreatePhotobookService::SUBTITLE_MAX_LENGTH + 1), 
        cover_media_id: 0,
        cover_media_taken_at: '2018/04/01',
        photobook_pages: []
      )
    }
  end

  test 'should raise CommentTooLongError when comment is too long' do
    service = CreatePhotobookService.new(
      album_model: MockAlbum.new(children: [
        MockChild.new(name: '太郎', birthday: Time.zone.parse('2019/01/01'))
      ]),
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )

    assert_raise(CreatePhotobookService::CommentTooLongError) {
      service.call(
        album_id: 0,
        account_id: 0,
        title: nil,
        subtitle: nil,
        cover_media_id: 0,
        cover_media_taken_at: '2018/04/01',
        photobook_pages: [
          { 
            page_number: 1,
            media_id: 1,
            comment: 'A' * (CreatePhotobookService::COMMENT_MAX_LENGTH + 1)
          }
        ]
      )
    }
  end
end

class MockAlbum
  attr_accessor :children

  def initialize(children:)
    @children = children
  end
  
  def find_by(id:)
    MockAlbum.new(children: @children)
  end
end

class MockEmptyAlbum
  def find_by(id:)
    nil
  end
end

class MockChild
  attr_accessor :name, :birthday

  def initialize(name:, birthday:)
    @name = name
    @birthday = birthday
  end
end

class MockPhotobook
  attr_accessor :id, :album_id, :account_id, :cover_media_id, :cover_media_taken_at, :title, :subtitle

  def initialize(
    id: nil,
    album_id: nil,
    account_id: nil,
    cover_media_id: nil,
    cover_media_taken_at: nil,
    title: nil,
    subtitle: nil
  )
    @id = id
    @album_id = album_id
    @account_id = account_id
    @cover_media_id = cover_media_id
    @cover_media_taken_at = cover_media_taken_at
    @title = title
    @subtitle = subtitle
  end

  def create(
    album_id:,
    account_id:,
    cover_media_id:,
    cover_media_taken_at:,
    title:,
    subtitle:
  )
    MockPhotobook.new(
      id: 0,
      album_id: album_id,
      account_id: account_id,
      cover_media_id: cover_media_id,
      cover_media_taken_at: cover_media_taken_at,
      title: title,
      subtitle: subtitle
    )
  end
end

class MockPhotobookPage
  attr_accessor :new_called_count, :import_called

  def initialize
    @new_called_count = 0
    @import_called = false
  end

  def new(
    photobook_id:,
    page_number:,
    media_id:,
    comment:
  )
    @new_called_count += 1
  end

  def import(pages)
    @import_called = true
  end
end
