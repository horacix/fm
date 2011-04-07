# == Schema Information
# Schema version: 20110401225751
#
# Table name: fund_performances
#
#  id               :integer(4)      not null, primary key
#  specific_fund_id :integer(4)
#  calculation_date :date
#  period           :integer(4)
#  period_type      :string(255)
#  rate             :integer(10)
#  created_at       :datetime
#  updated_at       :datetime
#

class FundPerformance < ActiveRecord::Base
  belongs_to :specific_fund
  scope :active, lambda { where(:calculation_date => Date.today) }
end

