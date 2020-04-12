# == Schema Information
#
# Table name: order_shipments
#
#  id         :bigint           not null, primary key
#  quantity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address_id :bigint           not null
#  order_id   :bigint           not null
#
class OrderShipment < ApplicationRecord
  belongs_to :address
end
