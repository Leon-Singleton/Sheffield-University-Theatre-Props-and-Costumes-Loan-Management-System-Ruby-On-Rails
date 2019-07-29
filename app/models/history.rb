# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  item       :string
#  category   :string
#  loan_count :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class History < ApplicationRecord
  
end
