class SpecificFund < ActiveRecord::Base
  belongs_to :fund
  belongs_to :series
  has_many :quotes

  def save_quote(date, quote)
    quotes.create(:date => date, :quote => quote)
  end
end

