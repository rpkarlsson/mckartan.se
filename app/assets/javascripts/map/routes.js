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
      callback();
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
      }
    );

    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
      }
    });
  }


   // Save the section
  function saveSection (maxDistance) {
    var leg = directionsDisplay.getDirections().routes[0].legs[0];

    // Validate section distance
    if (leg.distance.value <= maxDistance) {
      dataToSend = buildSectionJson(leg);
      r2.post(config.section.jsonUrl, dataToSend, sectionSaved);
      r2.changeToLoading(saveSectionButton, "Sparar");

    } else {
      alert("Sträckan måste vara mindre än " + maxDistance / 1000 + " km.");
    }

  }


  return {

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

    saveSection: saveSection

  };
});
