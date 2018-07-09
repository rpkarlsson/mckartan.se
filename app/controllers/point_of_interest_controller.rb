class PointOfInterestController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  respond_to :json
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @points_of_interest = PointOfInterest.all
  end

  def create
    poi = PointOfInterest.new(point_of_interest_params)
    poi.user_id = current_user.id
    if poi.save
      flash[:success] = t ".success"
      render json: [point_of_interest: poi, url: root_path], status: :created
    else
      render json: poi.errors,
      status: :unprocessable_entity
    end
  end

  private def point_of_interest_params
    params
      .require(:point_of_interest)
      .permit(:lng, :lat)
  end

end
