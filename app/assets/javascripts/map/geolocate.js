// Geolocates a person centering the map on the location
modulejs.define("googleMaps/geolocate", function () {

   return function (map, callback) {

    if(navigator.geolocation) {

      navigator.geolocation.getCurrentPosition(function(position) {
        var pos = new google.maps.LatLng(position.coords.latitude,
                                         position.coords.longitude);
        map.setCenter(pos);
        map.setZoom(9);
        callback();
      }, function() {
        handleNoGeolocation(true);
      });

    }
  };
});
