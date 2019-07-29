# == Schema Information
#
# Table name: loans
#
#  id         :integer          not null, primary key
#  date_from  :datetime
#  date_until :datetime
#  returned   :boolean
#  request    :boolean
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_loans_on_item_id  (item_id)
#  index_loans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#

class Loan < ApplicationRecord
  include EpiCas::DeviseHelper
  belongs_to :item
  belongs_to :user


end
