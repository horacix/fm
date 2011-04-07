# == Schema Information
# Schema version: 20110329233030
#
# Table name: funds
#
#  id               :integer(4)      not null, primary key
#  run              :integer(4)
#  run_dv           :integer(4)
#  name             :string(255)
#  administrator_id :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#  fund_type_id     :integer(4)
#

class Fund < ActiveRecord::Base
  belongs_to :administrator
  belongs_to :fund_type
  has_many :specific_funds
  has_many :series, :through => :specific_funds

  validates_uniqueness_of :run
end

