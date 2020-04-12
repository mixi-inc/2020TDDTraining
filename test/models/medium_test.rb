# == Schema Information
#
# Table name: media
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  album_id      :bigint           not null
#  user_id       :bigint           not null
#  visibility_id :bigint           not null
#
require 'test_helper'

class MediumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
