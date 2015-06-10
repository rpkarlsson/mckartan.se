json.type "FeatureCollection"

json.features do
  json.array!(@sections) do |section|

    json.type  "Feature"

    json.properties do
      json.extract! section, :id, :distance, :duration, :start_address, :end_address, :summary
      json.url section_url(section, format: :json)
    end

    json.geometry do
      json.type "LineString"
      json.coordinates section.points.pluck(:long, :lat)
    end

  end
end
