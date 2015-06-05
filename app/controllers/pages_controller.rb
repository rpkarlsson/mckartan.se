# Handles all individual pages
class PagesController < ApplicationController


  # /about
  def about
  end


  # /
  def map
    # Informs the user that cookies are being used
    # if the user is new to the site.
    @current_user = current_user
    if cookies[:cookie].blank?
      flash.now[:alert] = t("cookie_prompt")
      cookies[:cookie] = 1
    end
  end


end
