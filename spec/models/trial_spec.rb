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

  describe "all_active" do
    it "returns in ASC order" do
      user = Fabricate(:user)
      second_expiring_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user_id: user.id)
      third_expiring_trial = Fabricate(:trial, expiration_date: 27.days.from_now, user_id: user.id)
      first_expring_trial = Fabricate(:trial, expiration_date: 7.days.from_now, user_id: user.id)
      expect(Trial.all_active(user)).to eq([first_expring_trial, second_expiring_trial, third_expiring_trial])
    end

    it "only returns trials that have not expired" do
      user = Fabricate(:user)
      active_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user_id: user.id)
      expired_trial = Fabricate(:trial, expiration_date: 17.days.ago, user_id: user.id)
      expect(Trial.all_active(user)).to eq([active_trial])
    end
  end

  describe "all_expired" do
    it "returns in ASC order" do
      user = Fabricate(:user)
      second_expired_trial = Fabricate(:trial, expiration_date: 17.days.ago, user_id: user.id)
      first_expired_trial = Fabricate(:trial, expiration_date: 27.days.ago, user_id: user.id)
      third_expired_trial = Fabricate(:trial, expiration_date: 7.days.ago, user_id: user.id)
      expect(Trial.all_expired(user)).to eq([first_expired_trial, second_expired_trial, third_expired_trial])
    end

    it "only returns expired trials" do
      user = Fabricate(:user)
      active_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user_id: user.id)
      expired_trial = Fabricate(:trial, expiration_date: 17.days.ago, user_id: user.id)
      expect(Trial.all_expired(user)).to eq([expired_trial])
    end
  end
end
