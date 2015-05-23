class AddUserToTrials < ActiveRecord::Migration
  def change
    add_reference :trials, :user, index: true
  end
end
