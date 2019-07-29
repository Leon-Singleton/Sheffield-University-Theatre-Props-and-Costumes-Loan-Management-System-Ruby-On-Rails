# == Schema Information
#
# Table name: subcategories
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

class Subcategory < ApplicationRecord
    validates :name, presence: true
    validates_uniqueness_of :name, :scope => :category_id
    belongs_to :category
    has_many :items

    has_many :item, dependent: :destroy
end
