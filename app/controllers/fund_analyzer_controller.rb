class FundAnalyzerController < ApplicationController
  def list
    @funds = Administrator.find(params[:id]).specific_funds
  end
end

