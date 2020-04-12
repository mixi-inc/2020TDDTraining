require 'test_helper'

class PhotobookRepositoryTest < ActiveSupport::TestCase
  test 'should return PhotobookEntity' do
    repository = PhotobookRepository.new(
      photobook_model: MockPhotobook.new,
      photobook_page_model: MockPhotobookPage.new
    )
    photobook = repository.create(
      album_id: 0,
      account_id: 0,
      cover_media_id: 0,
      cover_media_taken_at: Time.zone.parse('2020/04/01'),
      title: '2020年4月のアルバム',
      subtitle: '太郎1歳3ヶ月・次郎0歳3ヶ月',
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
    assert(photobook.is_a?(PhotobookEntity))
    assert_equal(0, photobook.album_id)
    assert_equal(0, photobook.account_id)
    assert_equal(0, photobook.cover_media_id)
    assert_equal(Time.zone.parse('2020/04/01'), photobook.cover_media_taken_at)
    assert_equal('2020年4月のアルバム', photobook.title)
    assert_equal('太郎1歳3ヶ月・次郎0歳3ヶ月', photobook.subtitle)
    assert_equal(2, photobook.photobook_pages.count)
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
  attr_accessor :create_called_count

  def initialize
    @create_called_count = 0
    @import_called = false
  end

  def create(
    photobook_id:,
    page_number:,
    media_id:,
    comment:
  )
    @create_called_count += 1
  end
end
