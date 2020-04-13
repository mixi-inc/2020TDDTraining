# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  address    :string(255)      not null
#  name       :string(255)      not null
#  quantity   :integer          not null
#  zipcode    :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
class Address < ApplicationRecord
end