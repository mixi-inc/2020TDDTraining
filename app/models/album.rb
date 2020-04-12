# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Album < ApplicationRecord
  has_many :children
  has_many :users
  has_many :visibilities
end
