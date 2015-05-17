class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.string :name
      t.string :url
      t.string :cancel_url
      t.text :instructions
      t.timestamps
    end
  end
end
