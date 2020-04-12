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
class Order < ApplicationRecord
  belongs_to :account
  belongs_to :photobook
  belongs_to :product
  has_many :order_shipments
end
