// The controller for the maps funtionality
modulejs.define("googleMaps",
  [
    "artoo",
   "googleMaps/geolocate",
   "googleMaps/routes"
  ], function (r2, geolocate, routes) {

  return {

    init: function () {
      var map,
          locateButton    = document.getElementById("geolocate-button");
          addRouteButton  =  document.getElementById("new-section-button");

          mapOptions = {
            zoom: 5,
            minZoom: 5,
            center: { lat: 62.5665586, lng: 13.8000050},
            mapTypeControl: false
          },

          config = {
            canvasId: "map-canvas",

            section: {
              url: "/sections/",
              jsonUrl: "/sections.json",
            }
          };

      function renderMap (elementId, options) {
        return new google.maps.Map(document.getElementById(elementId), options);
      }

      if (document.getElementById(config.canvasId)) {
        map = renderMap(config.canvasId, mapOptions);
      }

      // Add geolocation to button

      if (locateButton) {
        locateButton.addEventListener("click", function () {
          r2.disableButton(locateButton);
          r2.changeButtonText(locateButton, "Söker...");
          geolocate(map, function () {
            r2.changeButtonText(locateButton, "Hitta mig");
            r2.enableButton(locateButton);
          });
        });
      }

      if (addRouteButton) {
        addRouteButton.addEventListener("click", function () {
          routes.drawRoute(map);
        });
      }


    }
  };

});
