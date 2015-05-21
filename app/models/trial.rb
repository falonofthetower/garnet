class Trial < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :expiration_date
  validates_presence_of :user_id
  belongs_to :user

  def self.all_by_expiration(current_user)
    where(user_id: current_user.id).order("expiration_date ASC")
  end
end
