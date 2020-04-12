require 'test_helper'

class PhotobooksControllerTest < ActionDispatch::IntegrationTest
  test "valid response" do
    post "/api/v1/albums/#{albums(:first).id}/photobooks", params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2020-04-01',
      photobook_pages: [
        {
          page_number: 1,
          media_id: 1,
          comment: 'いいね'
        },
        {
          page_number: 2,
          media_id: 2,
          comment: 'いいよ'
        }
      ]
    }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal '2020年4月のアルバム', json_response['title']
    assert_equal '太郎1歳3ヶ月・次郎0歳3ヶ月', json_response['subtitle']
  end

  test "valid response - title and subtitle is filled" do
    post "/api/v1/albums/#{albums(:first).id}/photobooks", params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2020-04-01',
      title: '初めてのフォトブック',
      subtitle: '最高の思い出',
      photobook_pages: [
        {
          page_number: 1,
          media_id: 1,
          comment: 'いいね'
        },
        {
          page_number: 2,
          media_id: 2,
          comment: 'いいよ'
        }
      ]
    }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal '初めてのフォトブック', json_response['title']
    assert_equal '最高の思い出', json_response['subtitle']
  end

  test "valid response - formatted subtitle is over limit length" do
    post "/api/v1/albums/#{albums(:second).id}/photobooks", params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2020-04-01',
      photobook_pages: [
        {
          page_number: 1,
          media_id: 1,
          comment: 'いいね'
        },
        {
          page_number: 2,
          media_id: 2,
          comment: 'いいよ'
        }
      ]
    }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 'Family Album', json_response['subtitle']
  end

  test "valid response - children are not borned" do
    post "/api/v1/albums/#{albums(:first).id}/photobooks", params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2018-04-01',
      photobook_pages: [
        {
          page_number: 1,
          media_id: 1,
          comment: 'いいね'
        },
        {
          page_number: 2,
          media_id: 2,
          comment: 'いいよ'
        }
      ]
    }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal '2018年4月のアルバム', json_response['title']
    assert_equal '太郎・次郎', json_response['subtitle']
  end

  test "invalid response - album not found" do
    post '/api/v1/albums/0/photobooks', params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2020-04-01',
      photobook_pages: []
    }
    assert_response :not_found
    json_response = JSON.parse(response.body)
    assert_equal 'album_not_found', json_response['code']
  end

  test "invalid response - title too long" do
    post "/api/v1/albums/#{albums(:first).id}/photobooks", params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2020-04-01',
      title: 'A' * 21,
      photobook_pages: []
    }
    assert_response :bad_request
    json_response = JSON.parse(response.body)
    assert_equal 'too_long_photobook_title', json_response['code']
  end

  test "invalid response - subtitle too long" do
    post "/api/v1/albums/#{albums(:first).id}/photobooks", params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2020-04-01',
      subtitle: 'A' * 21,
      photobook_pages: []
    }
    assert_response :bad_request
    json_response = JSON.parse(response.body)
    assert_equal 'too_long_photobook_subtitle', json_response['code']
  end

  test "invalid response - comment too long" do
    post "/api/v1/albums/#{albums(:first).id}/photobooks", params: {
      account_id: accounts(:first).id,
      cover_media_id: 0,
      cover_media_taken_at: '2020-04-01',
      photobook_pages: [
        {
          page_number: 1,
          media_id: 1,
          comment: 'A' * 201
        },
        {
          page_number: 2,
          media_id: 2,
          comment: 'いいよ'
        }
      ]
    }
    assert_response :bad_request
    json_response = JSON.parse(response.body)
    assert_equal 'too_long_photobook_comment', json_response['code']
  end
end
