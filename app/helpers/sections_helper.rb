module SectionsHelper
  # Converts google distance to km
  def to_km meters
    (meters / 1000).round(1)
  end

  # Converts google duration to minutes
  def to_minutes gmapsTime
    (gmapsTime / 60).round
  end
end
