class SectionsController < ApplicationController

  before_filter :check_format



  def index
    respond_to do |format|
      format.json { @sections = Section.all }
    end
  end


  private


  def check_format
    render :nothing => true, :status => 406 unless params[:format] == 'json'
  end


end
