require 'spec_helper'

describe Trial do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:expiration_date) }
  it { should belong_to(:user) }

  it "saves itself" do
    trial = Fabricate(:trial)
    expect(Trial.first).to eq(trial)
  end

  describe ".all_active" do
    let(:user) { Fabricate(:user) }

    it "returns empty when there are no active trials" do
      Fabricate(:trial, expiration_date: 14.days.ago, user: user)
      expect(Trial.all_active(user)).to eq([])
    end

    it "returns the users active trial" do
      active_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      expect(Trial.all_active(user)).to eq([active_trial])
    end

    it "returns all the users active trials" do
      first_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      ugly_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      bored_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      skinny_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      fat_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      expect(Trial.all_active(user)).to match_array([first_trial, ugly_trial, bored_trial, skinny_trial, fat_trial])
    end

    it "returns in ASC order" do
      second_expiring_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      third_expiring_trial = Fabricate(:trial, expiration_date: 27.days.from_now, user: user)
      first_expring_trial = Fabricate(:trial, expiration_date: 7.days.from_now, user: user)
      expect(Trial.all_active(user)).to eq([first_expring_trial, second_expiring_trial, third_expiring_trial])
    end

    it "only returns trials that have not expired" do
      active_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      expired_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      expect(Trial.all_active(user)).to eq([active_trial])
    end
  end

  describe ".all_expired" do
    let(:user) { Fabricate(:user) }

    it "returns empty when there are no expired trials" do
      Fabricate(:trial, expiration_date: 14.days.from_now, user: user)
      expect(Trial.all_expired(user)).to eq([])
    end

    it "returns the users trial" do
      expired_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      expect(Trial.all_expired(user)).to eq([expired_trial])
    end

    it "returns all the users expired trials" do
      first_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      ugly_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      bored_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      skinny_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      fat_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      expect(Trial.all_expired(user)).to match_array([first_trial, ugly_trial, bored_trial, skinny_trial, fat_trial])
    end

    it "returns in ASC order" do
      second_expired_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      first_expired_trial = Fabricate(:trial, expiration_date: 27.days.ago, user: user)
      third_expired_trial = Fabricate(:trial, expiration_date: 7.days.ago, user: user)
      expect(Trial.all_expired(user)).to eq([first_expired_trial, second_expired_trial, third_expired_trial])
    end

    it "only returns expired trials" do
      active_trial = Fabricate(:trial, expiration_date: 17.days.from_now, user: user)
      expired_trial = Fabricate(:trial, expiration_date: 17.days.ago, user: user)
      expect(Trial.all_expired(user)).to eq([expired_trial])
    end

    it "returns trials expiring today" do
      expiries_today_trial = Fabricate(:trial, expiration_date:  Date.today, user: user)
      expect(Trial.all_expired(user)).to eq([expiries_today_trial])
    end
  end
end
