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

  def show
    @poi = PointOfInterest.find(params[:id])
    @user_is_creator = user_is_creator?
    @user_is_admin = user_is_admin?
    @partial = render_to_string partial: "point_of_interest/show"
  end

  def destroy
    @poi = PointOfInterest.find(params[:id])
    if user_is_creator? || user_is_admin?
      @poi.destroy
      flash[:success] = t ".success"
    else
      flash[:warning] = t ".warning"
    end
    redirect_to root_path
  end

  private def point_of_interest_params
    params
      .require(:point_of_interest)
      .permit(:lng, :lat)
  end

  private def user_is_creator?
    user_signed_in? and current_user.id == @poi.user.id
  end

  private def user_is_admin?
    user_signed_in? and current_user.id == 1
  end

end
