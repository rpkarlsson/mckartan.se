# Handles all individual pages
class PagesController < ApplicationController


  # /about
  def about
  end


  # /
  def map
    # Informs the user that cookies are being used
    # if the user is new to the site.
    if cookies[:cookie].blank?
      flash.now[:info] = t("cookie_prompt")
      cookies[:cookie] = { value: 1, expires: 1.year.from_now }
    end
  end


end
