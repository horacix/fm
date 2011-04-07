class CreateFundPerformances < ActiveRecord::Migration
  def self.up
    create_table :fund_performances do |t|
      t.integer :specific_fund_id
      t.date :calculation_date
      t.integer :period
      t.string :period_type
      t.decimal :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :fund_performances
  end
end
