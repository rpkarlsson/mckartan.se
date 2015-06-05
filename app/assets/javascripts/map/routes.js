modulejs.define("googleMaps/routes", function () {
  var directionsService = new google.maps.DirectionsService(),
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
    }
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
        computeTotalDistance(directionsDisplay.getDirections());
      }
    );

    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
      }
    });
  }


  return {

    cancel: function () {
      google.maps.event.removeListener(routeListener);

    },

    drawRoute: function (map) {

     routeListener = google.maps.event.addListener(map, "click", function(event) {
        addRoutePoint(map, event.latLng);
      });
    },

    listener: null

  };
});
