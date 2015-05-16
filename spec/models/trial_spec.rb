require 'spec_helper'

describe Trial do
  it { should validate_presence_of(:name) }

  it "saves itself" do
    trial = Fabricate(:trial)
    expect(Trial.first).to eq(trial)
  end
end
