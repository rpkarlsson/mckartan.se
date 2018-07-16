require 'rails_helper'

RSpec.describe PointOfInterest, type: :model do
  before(:each) do
    @poi = create(:point_of_interest)
  end

  it { expect(@poi).to be_valid }

  it "is invalid without lng" do
    @poi.lng = nil
    expect(@poi).to_not be_valid
  end

  it "is invalid without lat" do
    @poi.lat = nil
    expect(@poi).to_not be_valid
  end
end
