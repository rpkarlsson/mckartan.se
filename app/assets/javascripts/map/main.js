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
          locateButton    = document.getElementById("geolocate-button"),
          addRouteButton  = document.getElementById("new-section-button"),
          saveButton      = document.getElementById("save-button");

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

      // Add route functionality.
      // Changes the add section button to a cancel button
      // shows the save button
      if (addRouteButton) {
        routes.listener = function () {
          map.setOptions({ draggableCursor: 'crosshair' });
          routes.drawRoute(map);

          saveButton.classList.remove("hidden");

          // Change to abort button and
          r2.changeButtonText(addRouteButton, "Avbryt");
          r2.changeButtonClass(addRouteButton, "alert");
          addRouteButton.removeEventListener("click", routes.listener, false);

          addRouteButton.addEventListener("click", function () {
            routes.cancel();
            saveButton.classList.add("hidden");
            map.setOptions({ draggableCursor: 'url(http://maps.google.com/mapfiles/openhand.cur), move' });
            r2.changeButtonText(addRouteButton, "Skapa sträcka");
            r2.changeButtonClass(addRouteButton, "default")
            addRouteButton.addEventListener("click", routes.listener);
          });
        }

        addRouteButton.addEventListener("click", routes.listener);
      }


    }
  };

});
