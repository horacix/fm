class Series < ActiveRecord::Base
  has_many :specific_funds
  has_many :funds, :through => :specific_funds
  validates_uniqueness_of :name
end
