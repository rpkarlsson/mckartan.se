class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  include UsersEngine::Authentication

  before_action :check_user

  protected


  def require_log_in
    unless @logged_in
      if request.format.json?
        render json: "Unauthorized request", status: :unauthorized
      else
        flash[:notice] = t("authenticate")
        redirect_to users_engine.login_url, status: :unauthorized
      end
    end
  end

end
