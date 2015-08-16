module SectionsHelper
  # Converts google distance to km
  def to_km meters
    (meters / 1000).round(1)
  end

  # Converts google duration to minutes
  def to_minutes gmapsTime
    (gmapsTime / 60).round
  end

  def user_is_creator?
    @logged_in and @current_user.id == @section.user.id
  end
end

