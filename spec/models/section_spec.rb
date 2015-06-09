require 'rails_helper'

RSpec.describe Section, type: :model do


  it "has a working factory" do
    expect(FactoryGirl.build(:section)).to be_valid
  end

  it "is invalid without a user_id" do
    expect(FactoryGirl.build(:section, user_id: nil)).to_not be_valid
  end

  it "is invalid without a distance" do
    expect(FactoryGirl.build(:section, distance: nil)).to_not be_valid
  end

  it "is invalid without a duration" do
    expect(FactoryGirl.build(:section, duration: nil)).to_not be_valid
  end

  it "is invalid without a start_address" do
    expect(FactoryGirl.build(:section, start_address: nil)).to_not be_valid
  end

  it "is invalid without a end_address" do
    expect(FactoryGirl.build(:section, end_address: nil)).to_not be_valid
  end

end
