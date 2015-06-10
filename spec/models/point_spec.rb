require 'rails_helper'

RSpec.describe Point, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.build(:point)).to be_valid
  end

  it "is invalid without a lng" do
    expect(FactoryGirl.build(:point, lng: nil)).to_not be_valid
  end

  it "is invalid without a lat" do
    expect(FactoryGirl.build(:point, lat: nil)).to_not be_valid
  end

end
