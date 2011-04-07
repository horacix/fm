# == Schema Information
# Schema version: 20110329233030
#
# Table name: fund_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class FundType < ActiveRecord::Base
  validates_uniqueness_of :name
end

