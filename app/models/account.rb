# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Account < ApplicationRecord
  has_secure_password
  has_many :users
end
