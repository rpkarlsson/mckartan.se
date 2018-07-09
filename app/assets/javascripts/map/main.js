// The controller for the maps funtionality
modulejs.define("googleMaps",
  [
   "artoo",
   "googleMaps/geolocate",
   "googleMaps/routes"
   // "googleMaps/infoWindow"
  ], function (r2, geolocate, routes) {

  var map, poiMarker,
      locateButton    = document.getElementById("geolocate-button"),
      addRouteButton  = document.getElementById("new-section-button"),
      saveButton      = document.getElementById("save-button"),
      addPointOfInterestButton = document.getElementById("new-poi-button"),
      mapOptions = {
        zoom: 5,
        minZoom: 5,
        center: { lat: 62.5665586, lng: 13.8000050},
        mapTypeControl: false,
      },
      config = {
        canvasId: "map-canvas",
        section: {
          url: "/sections/",
          jsonUrl: "/sections.json",
          maxDistance: 100000
        },
        poi: {
          jsonUrl: "/point_of_interest.json",
          url: "/point_of_interest"
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
        icon: "/signs/parking.png",
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
    addPointOfInterestButton.classList.remove("hidden");
    map.setOptions({ draggableCursor: 'url(http://maps.google.com/mapfiles/openhand.cur), move' });
    r2.changeButtonText(addRouteButton, "Ny sträcka");
    r2.changeButtonClass(addRouteButton, "default");
    addRouteButton.addEventListener("click", routes.listener);
    poiMarker.setMap(null);
    poiMarker = null;
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


  function changeToSaveFeatureState () {
    saveButton.classList.remove("hidden");
    addPointOfInterestButton.classList.add("hidden");
    r2.changeButtonText(addRouteButton, "Avbryt");
    r2.changeButtonClass(addRouteButton, "alert");
    addRouteButton.removeEventListener("click", routes.listener, false);
    addRouteButton.addEventListener("click",addCancelButtonEvents);
  }


  function addNewRouteButtonEvents () {
    routes.listener = function () {
      map.setOptions({ draggableCursor: 'crosshair' });
      routes.drawRoute(map, function () {
        map.setOptions({ draggableCursor: 'url(http://maps.google.com/mapfiles/openhand.cur), move' });
        saveButton.classList.remove("disabled");
      });
      changeToSaveFeatureState();
    };

    addRouteButton.addEventListener("click", routes.listener);
  }


  function addPoiListener (event) {
    poiMarker = new google.maps.Marker({position: event.latLng, map: map});
    saveButton.classList.remove("disabled");
  }


  function savePoi() {
    var payload = JSON.stringify(
      {lng: poiMarker.position.lng(), lat: poiMarker.position.lat()});
    r2.http.post(config.poi.url, payload , sectionSaved);
    r2.changeButtonText(saveButton, "Sparar");
    r2.changeButtonClass(saveButton, "disabled");
    r2.changeButtonClass(addRouteButton, "disabled");
  }


  function addSaveButtonEvents () {
    saveButton.addEventListener("click", function () {
      if (r2.buttonIsDisabled(saveButton))
        return false;

      if (poiMarker)
        return savePoi();

      if (routes.validateSection(config.section.maxDistance))
        saveSection();
    });
  }

  function addPointOfInterestButtonEvents () {
    addPointOfInterestButton.addEventListener("click", function () {
      changeToSaveFeatureState();
      map.setOptions({ draggableCursor: 'crosshair' });
      google.maps.event.addListenerOnce(map, "click", addPoiListener);
    });
  }


  return {
    init: function () {
      if (document.getElementById(config.canvasId)) {
        map = renderMap(config.canvasId, mapOptions);
        setStyle();
        map.data.loadGeoJson(config.section.jsonUrl);
        map.data.loadGeoJson(config.poi.jsonUrl);
        addMapClick();
      }

      if (locateButton) addLocateButtonEvents();
      if (addRouteButton) addNewRouteButtonEvents();
      if (saveButton) addSaveButtonEvents();
      if (addPointOfInterestButton) addPointOfInterestButtonEvents();
    }
  };
});
