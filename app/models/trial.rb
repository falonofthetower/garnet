class Trial < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :expiration_date

  def self.all_by_expiration
    all.order("created_at DESC")
  end
end
