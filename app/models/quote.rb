class Quote < ActiveRecord::Base
  belongs_to :specific_fund
  validates_uniqueness_of :date, :scope => :specific_fund_id
end
