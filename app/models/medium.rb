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
class Medium < ApplicationRecord
  belongs_to :album
  belongs_to :user
  has_one :visibility
end
