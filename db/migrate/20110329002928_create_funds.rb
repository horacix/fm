class CreateFunds < ActiveRecord::Migration
  def self.up
    create_table :funds do |t|
      t.integer :run
      t.integer :run_dv
      t.string :name
      t.integer :administrator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :funds
  end
end
