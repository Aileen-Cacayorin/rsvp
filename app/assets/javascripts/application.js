// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require_tree .

var map;

function initMap(locations) {
  var locations;
  var event_location;
  locations = locations.replace(/&quot;/g, '"');
  new_locations = JSON.parse(locations);
  main_location = new_locations[0]

  var bounds;
  bounds = new google.maps.LatLngBounds();
  map = new google.maps.Map(document.getElementById('map-canvas'), {
  center: {lat: main_location.latitude, lng: main_location.longitude},
  zoom: 12
  });

  var markers = [];
  new_locations.forEach(function(location) {
    var address = [];
    address.push(location.name),
    address.push(location.latitude);
    address.push(location.longitude);
    markers.push(address);
  });
  console.log(markers)

  for (var i = 0; i < markers.length; i++ ) {
       var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
       bounds.extend(position);
       marker = new google.maps.Marker({
           position: position,
           map: map,
           title: markers[i][0]

       });
     }
  map.fitBounds(bounds);

}
