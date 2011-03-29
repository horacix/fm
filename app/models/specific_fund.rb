class SpecificFund < ActiveRecord::Base
  belongs_to :fund
  belongs_to :series
end
