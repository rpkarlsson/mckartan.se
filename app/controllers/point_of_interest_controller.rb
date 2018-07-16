require 'feature_policy'

class PointOfInterestController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  respond_to :json
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @points_of_interest = PointOfInterest.all
  end

  def show
    @poi = PointOfInterest.find(params[:id])
    @user_may_destroy = FeaturePolicy.destroy?(@poi, current_user)
    @partial = render_to_string "point_of_interest/show", formats: :html, layout: false
    render "point_of_interest/show.json"
  end

  def create
    @poi = PointOfInterest.new(point_of_interest_params)
    @poi.user_id = current_user.id
    if @poi.save
      flash[:success] = t ".success"
      render json: [point_of_interest: @poi, url: root_path], status: :created
    else
      render json: @poi.errors,
      status: :unprocessable_entity
    end
  end

  def destroy
    @poi = PointOfInterest.find(params[:id])
    if FeaturePolicy.destroy?(@poi, current_user)
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
end
