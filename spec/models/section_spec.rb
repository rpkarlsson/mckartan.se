require "rails_helper"

RSpec.describe Section, type: :model do
  before(:each) do
   @section = build(:section_with_points)
  end

  it { expect(@section).to be_valid }

  it "is invalid without a user_id" do
    @section.user_id = nil
    expect(@section).to_not be_valid
  end

  it "is invalid without a distance" do
    @section.distance = nil
    expect(@section).to_not be_valid
  end

  it "is invalid without a duration" do
    @section.duration = nil
    expect(@section).to_not be_valid
  end

  it "is invalid without a start_address" do
    @section.start_address = nil
    expect(@section).to_not be_valid
  end

  it "is invalid without a end_address" do
    @section.end_address = nil
    expect(@section).to_not be_valid
  end

  it "requires a point" do
    @section.points = []
    expect(@section).to_not be_valid
  end

end
