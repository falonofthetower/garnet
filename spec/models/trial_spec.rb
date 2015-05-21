require 'spec_helper'

describe Trial do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:expiration_date) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:user) }

  it "saves itself" do
    trial = Fabricate(:trial)
    expect(Trial.first).to eq(trial)
  end

  it "should return in ASC order" do
    user = Fabricate(:user)
    second_expiring_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user_id: user.id)
    third_expiring_trial = Fabricate(:trial, expiration_date: 27.days.from_now, user_id: user.id)
    first_expring_trial = Fabricate(:trial, expiration_date: 7.days.from_now, user_id: user.id)
    expect(Trial.all_by_expiration(user)).to eq([first_expring_trial, second_expiring_trial, third_expiring_trial])
  end
end
