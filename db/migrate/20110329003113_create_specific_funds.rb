class CreateSpecificFunds < ActiveRecord::Migration
  def self.up
    create_table :specific_funds do |t|
      t.integer :fund_id
      t.integer :series_id

      t.timestamps
    end
  end

  def self.down
    drop_table :specific_funds
  end
end
