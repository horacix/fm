class CreateSeries < ActiveRecord::Migration
  def self.up
    create_table :series do |t|
      t.string :name
      t.references :administrator

      t.timestamps
    end
  end

  def self.down
    drop_table :series
  end
end

