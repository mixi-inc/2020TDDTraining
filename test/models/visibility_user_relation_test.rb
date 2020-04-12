# == Schema Information
#
# Table name: visibility_user_relations
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#  visibility_id :bigint
#
require 'test_helper'

class VisibilityUserRelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
