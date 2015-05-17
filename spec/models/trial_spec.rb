require 'spec_helper'

describe Trial do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:expiration_date) }

  it "saves itself" do
    trial = Fabricate(:trial)
    expect(Trial.first).to eq(trial)
  end

  it "should return in DESC order" do
    second_expiring_trial = Fabricate(:trial, expiration_date: 17.days.from_now)
    third_expiring_trial = Fabricate(:trial, expiration_date: 27.days.from_now)
    first_expring_trial = Fabricate(:trial, expiration_date: 7.days.from_now)
    expect(Trial.all_by_expiration).to match_array([first_expring_trial, second_expiring_trial, third_expiring_trial])
  end
end
