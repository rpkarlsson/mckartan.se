require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
  describe "GET #index" do

    it "assigns @sections" do
      section = create(:section_with_points)
      get :index, format: :json
      expect(assigns(:sections)).to eq([section])
    end
  end

  describe "GET #show" do
    it "assigns a section" do
      section = create(:section_with_points)
      get :show, params: { id: section.id }, format: :json
      expect(assigns(:section)).to eq(section)
    end
  end


  describe "POST #create" do
    it "rejects non users" do
      post :create,
            format: :json,
            params: { section: nil }
      expect(response).to have_http_status(:unauthorized)
    end

    context "when logged in" do
      def post_new_section
        post :create,
              format: :json,
              params: {
                section: FactoryBot.attributes_for(:section),
                points: [[32, 33], [34, 44]]}
      end

      before do
        sign_in create(:user)
        post_new_section
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(assigns(:section)).to eq(Section.first) }

    end
  end
end
