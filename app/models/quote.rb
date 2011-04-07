# == Schema Information
# Schema version: 20110329233030
#
# Table name: quotes
#
#  id               :integer(4)      not null, primary key
#  specific_fund_id :integer(4)
#  date             :date
#  quote            :integer(10)
#  created_at       :datetime
#  updated_at       :datetime
#

class Quote < ActiveRecord::Base
  belongs_to :specific_fund
  validates_uniqueness_of :date, :scope => :specific_fund_id
  scope :ordered, order("date desc").limit(1)
end

