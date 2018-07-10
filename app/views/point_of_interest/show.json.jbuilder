
json.type "Feature"

json.properties do
  json.icon "parking"
  json.url point_of_interest_url(@poi)
  json.html @partial
end

json.geometry do
  json.type "Point"
  json.coordinates [@poi[:lng], @poi[:lat]]
end
