require 'rails_helper'

RSpec.describe Point, type: :model do

  before(:each) do
    @point = FactoryBot.build(:point)
    section = FactoryBot.build(:section)
    @point.section_id = section.id
    section.points << @point
    section.save
  end

  it "has a valid factory" do
    expect(@point).to be_valid
  end

  it "is invalid without a lng" do
    @point.lng = nil
    expect(@point).to_not be_valid
  end

  it "is invalid without a lat" do
    @point.lat = nil
    expect(@point).to_not be_valid
  end

end
