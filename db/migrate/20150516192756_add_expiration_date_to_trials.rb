class AddExpirationDateToTrials < ActiveRecord::Migration
  def change
    add_column :trials, :expiration_date, :date
  end
end
