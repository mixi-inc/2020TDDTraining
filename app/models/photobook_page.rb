# == Schema Information
#
# Table name: photobook_pages
#
#  id           :bigint           not null, primary key
#  comment      :string(255)
#  page_number  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  media_id     :bigint           not null
#  photobook_id :bigint           not null
#
class PhotobookPage < ApplicationRecord
  has_one :medium
  belongs_to :photobook
end
