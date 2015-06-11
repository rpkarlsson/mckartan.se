modulejs.define("googleMaps/routes", function () {
  var callback,
      directionsService = new google.maps.DirectionsService(),
      directionsDisplay,
      end,
      routeListener,
      marker;


  function addMarker (map, latLng) {
    return new google.maps.Marker({
      position: latLng,
      map: map
    });
  }


  function addRoutePoint (map, latLng) {
    if (!marker) {
      marker = addMarker(map, latLng);
    } else {
      calcRoute(map, marker.position, latLng);
      marker.setMap(null);
      google.maps.event.removeListener(routeListener);
      callback();
    }
  }


  function buildSectionJson () {
    var leg = directionsDisplay.getDirections().routes[0].legs[0];
    return JSON.stringify({
      section: {
        distance: leg.distance.value,
        duration: leg.duration.value,
        start_address: leg.start_address,
        end_address: leg.end_address,
      },
      points: extractPoints(leg)
    });
  }


  // Calculates and add the route to the view
  function calcRoute (map, origin, destination) {
    var  request = {
        origin: origin,
        destination: destination,
        travelMode: google.maps.TravelMode.DRIVING
      };

    directionsDisplay = directionsDisplay ||
                        new google.maps.DirectionsRenderer({draggable: true});

    directionsDisplay.setMap(map);

    google.maps.event.addListener(
      directionsDisplay, 'directions_changed', function() {
      }
    );

    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
      }
    });
  }


  // Extracts all points in a leg
  // Params: The leg taken from the googlemaps API
  function extractPoints (leg){
    var points = [];

    // Loop through all steps in a leg
    // calling them points
    Array.prototype.forEach.call(leg.steps, function(step) {
      // Loop through all paths and save long and lat to
      // out points array
      Array.prototype.forEach.call(step.path, function(path) {
        points.push([path.lng(), path.lat()]);
      });
    });
    return points;
  }


  function validateSection (maxDistance) {
   var leg = directionsDisplay.getDirections().routes[0].legs[0];
   if (leg.distance.value <= maxDistance) { return true; }
   alert("Sträckan måste vara mindre än " + maxDistance / 1000 + " km.");
   return false;
  }


  return {

    buildSectionJson: buildSectionJson,

    cancel: function () {
      google.maps.event.removeListener(routeListener);
      if (directionsDisplay) {
        directionsDisplay.setMap(null);
        directionsDisplay = null;
      }

      if (marker) {
        marker.setMap(null);
        marker = null;
      }
    },

    drawRoute: function (map, _callback) {
      callback = _callback;

     routeListener = google.maps.event.addListener(map, "click", function(event) {
        addRoutePoint(map, event.latLng);
      });
    },

    listener: null,
    validateSection: validateSection,
  };
});
