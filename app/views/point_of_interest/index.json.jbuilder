json.type "FeatureCollection"

json.features do
  json.array!(@points_of_interest) do |poi|
    json.type "Feature"

    json.properties do
      json.icon "parking"
      json.url point_of_interest_url(poi)
    end

    json.geometry do
      json.type "Point"
      json.coordinates [poi[:lng], poi[:lat]]
    end
  end
end
