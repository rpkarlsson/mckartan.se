require 'feature_policy'

class SectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  skip_before_action :verify_authenticity_token, only: [:create]

  before_action :check_format, except: [:destroy]
  before_action :set_section, only: [:show, :destroy]

  def index
    respond_to do |format|
      format.json { @sections = Section.all }
    end
  end

  def create
    @section = Section.new(section_params)
    @section.user_id = current_user.id
    add_points params[:points]

    respond_to do |format|
      if @section.save
        format.json {
          flash[:success] = t ".success"
          render json: [section: @section, url: root_path], status: :created }
      else
        format.json {
              render json: @section.errors,
              status: :unprocessable_entity }
      end
    end
  end

  def show
    @user_may_destroy = FeaturePolicy::destroy?(@section, current_user)
    @partial = render_to_string "sections/show", formats: :html, layout: false
    respond_to do |format|
      format.json
    end
  end

  def destroy
    if FeaturePolicy::destroy?(@section, current_user)
      @section.destroy
      flash[:success] = t ".success"
    else
      flash[:warning] = t ".warning"
    end
    redirect_to root_path
  end

  private def set_section
    @section = Section.find(params[:id])
  end

  private def check_format
    redirect_to root_path unless params[:format] == 'json'
  end

  private def section_params
    params.require(:section).permit(:distance, :duration, :start_address, :end_address)
  end


  private def add_points points
    points.each do |point|
      @section.points.new(lng: point.first, lat: point.last )
    end
  end

end
