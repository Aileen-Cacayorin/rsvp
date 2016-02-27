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
    address.push(location.street + ", " + location.city + ", " + location.state)
    markers.push(address);
  });

  // Info Window Content
  var infoWindowContent =[]
  for (var i = 0; i < markers.length; i++) {
    infoWindowContent.push(['<div class="info_content">' + '<h5>' + markers[i][0] + '</h5>' + markers[i][3] + '</div>'])
  };

  // Display multiple markers on a map
  var infoWindow = new google.maps.InfoWindow(), marker, i;

  for (var i = 0; i < markers.length; i++ ) {
       var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
       bounds.extend(position);
       marker = new google.maps.Marker({
           position: position,
           map: map,
           title: markers[i][0]

       });
       google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                infoWindow.setContent(infoWindowContent[i][0]);
                infoWindow.open(map, marker);
            }
        })(marker, i));
     }
  map.fitBounds(bounds);
}

function autoComplete() {
  var input = document.getElementById('search-text-field');
  var options = {
          types: ['establishment'],
          componentRestrictions: {country: 'us'}
        };
  var autocomplete = new google.maps.places.Autocomplete(input, options);
  // When the user selects an address from the dropdown, populate the address
  // fields in the form.
  google.maps.event.addListener(autocomplete, 'place_changed', function () {
              var place = autocomplete.getPlace();
              var street = place.address_components[0].long_name + " " + place.address_components[1].long_name
              document.getElementById('name').value = place.name;
              document.getElementById('address').value = street;
              document.getElementById('city').value = place.address_components[2].long_name;
              document.getElementById('state').value = place.address_components[3].short_name;
            });
  }
  $('#search-text-field').keydown(function (e) {
    if (e.which == 13 && $('.pac-container:visible').length) return false;
  });
