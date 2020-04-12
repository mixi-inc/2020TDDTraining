# == Schema Information
#
# Table name: photobooks
#
#  id                   :bigint           not null, primary key
#  cover_media_taken_at :datetime         not null
#  subtitle             :string(255)      not null
#  title                :string(255)      not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  album_id             :bigint           not null
#  cover_media_id       :bigint           not null
#
class Photobook < ApplicationRecord
  belongs_to :album
  belongs_to :account
  has_one :cover_media, class_name: 'Medium'
  has_many :photobook_pages
end
