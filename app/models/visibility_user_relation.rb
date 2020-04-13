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
class VisibilityUserRelation < ApplicationRecord
  belongs_to :visibility
  has_one :user
end