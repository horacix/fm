# == Schema Information
# Schema version: 20110329233030
#
# Table name: series
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)
#  administrator_id :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

class Series < ActiveRecord::Base
  belongs_to :administrator
  has_many :specific_funds
  has_many :funds, :through => :specific_funds
  validates_uniqueness_of :name, :scope => :administrator_id
end

