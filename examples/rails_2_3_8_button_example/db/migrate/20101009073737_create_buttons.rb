class CreateButtons < ActiveRecord::Migration
  def self.up
    create_table :buttons do |t|
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :buttons
  end
end
