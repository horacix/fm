class Series < ActiveRecord::Base
  belongs_to :administrator
  has_many :specific_funds
  has_many :funds, :through => :specific_funds
  validates_uniqueness_of :name, :scope => :administrator_id
end

