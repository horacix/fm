class Administrator < ActiveRecord::Base
  has_many :funds
  has_many :series
  validates_uniqueness_of :code
end

