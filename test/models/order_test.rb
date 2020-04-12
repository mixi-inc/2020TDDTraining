# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  price         :integer          not null
#  shipping_cost :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint           not null
#  content_id    :bigint           not null
#  product_id    :bigint           not null
#
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
