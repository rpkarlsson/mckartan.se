require 'rails_helper'
require 'helpers/users_helper'

RSpec.describe SectionsController, type: :controller do

  let(:section) {
    s = FactoryBot.build(:section)
    s.points << FactoryBot.build(:point)
    s.save
    s
  }

  let(:user)    { FactoryBot.create(:user) }

  describe "GET #index" do

    before do
      get :index, format: :json
    end

    it "assigns sections" do
      expect(assigns(:sections)).to eq([section])
    end

    it "renders correct json"
  end

  describe "GET #show" do
    before do
      get :show, params: { id: section.id }, format: :json
    end

    it "assigns a section" do
      expect(assigns(:section)).to eq(section)
    end
  end


  describe "POST #create" do
    context "when not logged in" do

      before do
        post :create,
              format: :json,
              params: { section: FactoryBot.attributes_for(:section) }
      end

      it "response has http status unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "stores the params in session"
    end


    context "when logged in" do
      before do
        sign_in user
      end

      context "posting valid params" do

        before do
          post :create,
                format: :json,
                params: {
                  section: FactoryBot.attributes_for(:section),
                  points: [[32, 33], [34, 44]]}
        end

        it "creats a new section" do
          expect{
            post :create,
                  format: :json,
                  params: {section: FactoryBot.attributes_for(:section),
                  points: [[32, 33], [34, 44]]}
          }.to change(Section, :count).by(1)
        end

        it "has http status created" do
          expect(response).to have_http_status(:created)
        end

        it "assigns @section" do
          expect(assigns(:section)).to eq(Section.first)
        end

        it "has a success flash"
      end
    end
  end

end
