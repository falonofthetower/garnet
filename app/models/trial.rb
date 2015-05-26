class Trial < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :expiration_date
  belongs_to :user

  def self.all_active(current_user)
    where("user_id = ? and expiration_date > ?", current_user.id, Time.zone.today).order(:expiration_date)
  end

  def self.all_expired(current_user)
    where("user_id = ? and expiration_date <= ?", current_user.id, Time.zone.today).order(:expiration_date)
  end
end
