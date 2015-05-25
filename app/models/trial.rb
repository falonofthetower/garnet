class Trial < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :expiration_date
  validates_presence_of :user_id
  belongs_to :user

  def self.all_active(current_user)
    where(user_id: current_user.id).where("expiration_date > ?", Time.zone.today).order("expiration_date ASC")
  end

  def self.all_expired(current_user)
    where(user_id: current_user.id).where("expiration_date < ?", Time.zone.today).order("expiration_date ASC")
  end

  def expired

  end

  def active

  end
end
