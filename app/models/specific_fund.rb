# == Schema Information
# Schema version: 20110329233030
#
# Table name: specific_funds
#
#  id         :integer(4)      not null, primary key
#  fund_id    :integer(4)
#  series_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class SpecificFund < ActiveRecord::Base
  belongs_to :fund
  belongs_to :series
  has_many :quotes
  has_many :fund_performances

  def save_quote(date, quote)
    quotes.create(:date => date, :quote => quote)
  end

  def year_performance(nper)
    perf = fund_performances.active.select(:rate).where(:period => nper, :period_type => 'year').first
    if perf.nil?
      latest_quote = quotes.ordered.first
      latest_date = latest_quote.date
      prev_date = latest_date << nper*12
      prev_quote = quotes.where("date <= :prev_date", :prev_date => prev_date).ordered.first
      if prev_quote.nil?
        perf = -1000000
      else
        perf = rate(nper, prev_quote.quote, latest_quote.quote)
      end
    end
  end

  def rate(nper, pv, fv)
    return ((fv.to_f/pv.to_f)**(1.0/nper))-1.0
  end
end

