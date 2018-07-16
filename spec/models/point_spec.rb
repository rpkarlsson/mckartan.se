require 'rails_helper'

RSpec.describe Point, type: :model do
  before(:each) do
    section = build(:section)
    @point = build(:point)
    @point.section = section
  end

  it { expect(@point).to be_valid }

  it "is invalid without a lng" do
    @point.lng = nil
    expect(@point).to_not be_valid
  end

  it "is invalid without a lat" do
    @point.lat = nil
    expect(@point).to_not be_valid
  end

end
