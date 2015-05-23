class Trial < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :expiration_date
  validates_presence_of :user_id
  belongs_to :user

  def self.for_user_where_not_expired(current_user)
    where(user_id: current_user.id).where("expiration_date > ?", Time.zone.today).order("expiration_date ASC")
  end
end
