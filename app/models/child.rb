# == Schema Information
#
# Table name: children
#
#  id         :bigint           not null, primary key
#  birthday   :datetime         not null
#  name       :string(255)      not null
#  sex        :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :bigint           not null
#
class Child < ApplicationRecord
  belongs_to :album
end
