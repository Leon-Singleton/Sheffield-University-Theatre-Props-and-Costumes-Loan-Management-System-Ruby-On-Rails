# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  name            :string
#  code            :string
#  description     :text
#  costume         :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  subcategory_id  :integer
#  category_id     :integer
#  colour_id       :integer
#  item_image_file :string
#

class Item < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :code
  belongs_to :subcategory
  belongs_to :colour
  belongs_to :category
  mount_uploader :item_image_file, ItemImageUploader


  has_many :loan, dependent: :destroy


end
