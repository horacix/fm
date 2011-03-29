class Administrator < ActiveRecord::Base
  has_many :funds
  validates_uniqueness_of :code
end
