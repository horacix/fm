class CreateFundTypes < ActiveRecord::Migration
  def self.up
    create_table :fund_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :fund_types
  end
end
