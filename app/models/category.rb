# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name
  #has_and_belongs_to_many :categories
  has_many :subcategories
  #has_many :items

  has_many :item, dependent: :destroy
  has_many :subcategory, dependent: :destroy
end
