# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  nickname     :string(255)      not null
#  relationship :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint           not null
#  album_id     :bigint           not null
#
class User < ApplicationRecord
  belongs_to :album
  belongs_to :user
  belongs_to :account
end
