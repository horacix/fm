# == Schema Information
# Schema version: 20110329233030
#
# Table name: administrators
#
#  id         :integer(4)      not null, primary key
#  code       :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Administrator < ActiveRecord::Base
  has_many :funds
  has_many :specific_funds, :through => :funds
  has_many :series
  validates_uniqueness_of :code
end

