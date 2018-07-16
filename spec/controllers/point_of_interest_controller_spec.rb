require 'rails_helper'

RSpec.describe PointOfInterestController, type: :controller do
  describe "GET #index" do
    it "assigns @points_of_interests" do
      poi = create(:point_of_interest)
      get :index, format: :json
      expect(assigns(:points_of_interest)).to eq([poi])
    end
  end

  describe "GET #show" do
    it "assigns a poi" do
      poi = create(:point_of_interest)
      get :show, params: { id: poi.id }, format: :json
      expect(assigns(:poi)).to eq(poi)
    end
  end


  describe "POST #create" do
    it "rejects non users" do
      post :create,
            format: :json,
            params: { }
      expect(response).to have_http_status(:unauthorized)
    end

    context "when logged in" do
      def post_new_poi
        post :create,
              format: :json,
              params: { point_of_interest: attributes_for(:point_of_interest) }
      end

      before do
        sign_in create(:user)
        post_new_poi
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(assigns(:poi)).to eq(PointOfInterest.first) }
    end
  end
end
