# == Schema Information
#
# Table name: visibilities
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :bigint           not null
#
class Visibility < ApplicationRecord
  belongs_to :album
  belongs_to :media
  has_many :visibility_user_relations
end
