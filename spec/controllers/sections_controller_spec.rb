require 'rails_helper'

RSpec.describe SectionsController, type: :controller do

  let(:section) { FactoryGirl.create(:section) }

  it "assigns sections" do
    get :index, format: :json
    expect(assigns(:sections)).to eq([section])
  end

end
