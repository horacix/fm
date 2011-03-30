class Fund < ActiveRecord::Base
  belongs_to :administrator
  belongs_to :fund_type
  has_many :specific_funds
  has_many :series, :through => :specific_funds

  validates_uniqueness_of :run
end

