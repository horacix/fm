class AddFundTypeIdToFund < ActiveRecord::Migration
  def self.up
    add_column :funds, :fund_type_id, :integer
  end

  def self.down
    remove_column :funds, :fund_type_id
  end
end
