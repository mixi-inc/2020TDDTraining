# == Schema Information
#
# Table name: photobooks
#
#  id                   :bigint           not null, primary key
#  cover_media_taken_at :datetime         not null
#  subtitle             :string(255)      not null
#  title                :string(255)      not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  album_id             :bigint           not null
#  cover_media_id       :bigint           not null
#
require 'test_helper'

class PhotobookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
