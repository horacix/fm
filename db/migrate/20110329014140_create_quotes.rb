class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.integer :specific_fund_id
      t.date :date
      t.decimal :quote

      t.timestamps
    end
    add_index :quotes, :specific_fund_id
    add_index :quotes, :date
  end

  def self.down
    drop_table :quotes
  end
end
