require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = build(:user)
  end

  it "has a working factory" do
    expect(@user).to be_valid
  end

  it "must have a username" do
    @user.username = nil
    expect(@user).to_not be_valid
  end

  it "must be a unique username" do
    @user.save
    second_user = build(:user)
    second_user.username = @user.username
    expect(second_user).to_not be_valid
  end

end
