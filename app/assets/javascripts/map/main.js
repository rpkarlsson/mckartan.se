// The controller for the maps funtionality
modulejs.define("googleMaps",
  [
   "artoo",
   "googleMaps/geolocate",
   "googleMaps/routes"
   // "googleMaps/infoWindow"
  ], function (r2, geolocate, routes) {

  var map,
      locateButton    = document.getElementById("geolocate-button"),
      addRouteButton  = document.getElementById("new-section-button"),
      saveButton      = document.getElementById("save-button"),

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
          maxDistance: 100000
        }
      };



  function renderMap (elementId, options) {
    return new google.maps.Map(document.getElementById(elementId), options);
  }


   // Save the section
  function saveSection () {
    r2.http.post(config.section.jsonUrl, routes.buildSectionJson(), sectionSaved);
    r2.changeButtonText(saveButton, "Sparar");
    r2.changeButtonClass(saveButton, "disabled");
    r2.changeButtonClass(addRouteButton, "disabled");
  }


  function sectionSaved (event) {
    var response, flash;
    if (event.target.status === 201) {
      window.location = "/";
    } else if (event.target.status === 401) {

    }
  }



  function setStyle () {
    map.data.setStyle(function(feature) {
      return ({
        fillColor: 'darkred',
        strokeColor: 'darkred',
        strokeWeight: 3
      });
    });
  }


  /* EVENTS */

  function addMapClick () {
    map.data.addListener("click", function (event) {
      var feature = event.feature;

      r2.http.get(event.feature.getProperty("url"), function (event) {
        var infowindow = new google.maps.InfoWindow(),
            content = JSON.parse(event.target.response).properties.html;
            where = feature.getGeometry().getAt(0);


        infowindow.setContent(content);
        infowindow.setPosition(where);
        infowindow.open(map);
      });
    });
  }

  /* BUTTONS */

  function addCancelButtonEvents () {
    routes.cancel();
    saveButton.classList.add("hidden");
    saveButton.classList.add("disabled");
    map.setOptions({ draggableCursor: 'url(http://maps.google.com/mapfiles/openhand.cur), move' });
    r2.changeButtonText(addRouteButton, "Ny sträcka");
    r2.changeButtonClass(addRouteButton, "default");
    addRouteButton.addEventListener("click", routes.listener);
  }


  function addLocateButtonEvents () {
   locateButton.addEventListener("click", function () {
      if (r2.buttonIsDisabled(locateButton)) { return false; }
      r2.disableButton(locateButton);
      r2.changeButtonText(locateButton, "Söker...");
      geolocate(map, function () {
        r2.changeButtonText(locateButton, "Hitta mig");
        r2.enableButton(locateButton);
      });
    });
  }


  function addNewRouteButtonEvents () {
    routes.listener = function () {
      map.setOptions({ draggableCursor: 'crosshair' });
      routes.drawRoute(map, function () {
        map.setOptions({ draggableCursor: 'url(http://maps.google.com/mapfiles/openhand.cur), move' });
        saveButton.classList.remove("disabled");
      });
      saveButton.classList.remove("hidden");
      // Change to abort button and
      r2.changeButtonText(addRouteButton, "Avbryt");
      r2.changeButtonClass(addRouteButton, "alert");
      addRouteButton.removeEventListener("click", routes.listener, false);
      addRouteButton.addEventListener("click",addCancelButtonEvents);
    };
    addRouteButton.addEventListener("click", routes.listener);
  }


  function addSaveButtonEvents () {
    saveButton.addEventListener("click", function () {
      if (r2.buttonIsDisabled(saveButton)) {
        return false;
      } else if (routes.validateSection(config.section.maxDistance)) {
        saveSection();
      }
    });
  }


  /* PUBLIC API */

  return {

    init: function () {

      if (document.getElementById(config.canvasId)) {
        map = renderMap(config.canvasId, mapOptions);
        setStyle();
        map.data.loadGeoJson(config.section.jsonUrl);
        addMapClick();
      }

      if (locateButton) { addLocateButtonEvents(); }

      if (addRouteButton) { addNewRouteButtonEvents(); }

      if (saveButton) { addSaveButtonEvents(); }

    }
  };
});
