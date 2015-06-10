class SectionsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :check_format
  before_action :require_log_in, except: [:index]



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
      if true #@section.save
        format.json {
          flash[:success] = t ".success"
          flash = render_to_string(partial: "shared/flash", formats: :html)
          render json: [section: @section,
                        flash: flash,
                         url: root_path],
                         status: :created }
      else
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def check_format
    render :nothing => true, :status => 406 unless params[:format] == 'json'
  end


  def section_params
    params.require(:section).permit(:distance, :duration, :start_address, :end_address)
  end


  def add_points points
    points.each do |point|
      @section.points.new(lng: point.first, lat: point.last )
    end
  end

end
