// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){
    if ($('.map').length > 0)
    {
        initialize();
    }
    if ($('.route').length > 0)
    {
        calcRoute();
    }
});
var geocoder;
var map;
var directionDisplay;
var directionsService = new google.maps.DirectionsService();
var pois;
var waypoints = [];

var colors = [];

colors[0] = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
colors[1] = 'http://maps.google.com/mapfiles/ms/icons/orange-dot.png';
colors[2] = 'http://maps.google.com/mapfiles/ms/icons/ltblue-dot.png';
colors[3] = 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png';
colors[5] = 'http://maps.google.com/mapfiles/ms/icons/purple-dot.png';
colors[6] = 'http://maps.google.com/mapfiles/ms/icons/pink-dot.png';
colors[7] = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';

function initialize() {
    $('.marker-color').each(function(){
        $(this).attr("src", colors[$(this).data('color')]);
    });

    var latlng = new google.maps.LatLng(51.764696,5.526042);
    geocoder = new google.maps.Geocoder();
    // set direction render options
    var rendererOptions = {
            draggable: false,
            suppressMarkers: true
        };

    directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
    var myOptions = {
        zoom: 14,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false
    };
    // add the map to the map placeholder
    map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
    directionsDisplay.setMap(map);
    directionsDisplay.setPanel(document.getElementById("directionsPanel"));
    directionsDisplay.suppressMarkers = true;
    // Add a marker to the map for the end-point of the directions.
    // var marker = new google.maps.Marker({
    //     position: latlng,
    //     map: map,
    //     title:"Rodderhof, Oss"
    // });

    pois = $('#pois_by_interest').data('pois');
    console.log(pois);
    // generate waypoints and markers from same data as they should be on the same locations
    var start = "Berlin, Brandenburger Tor";
    var end = "Berlin, Hotel Atlon";

    // startLatLng = new google.maps.address("Berlin, Brandenburger Tor");
    // endLatLng = new google.maps.address("Berlin, Hotel Atlon");
    codeAddress("Berlin, Brandenburger Tor", "Brandenburger Tor");
    codeAddress("Berlin, Hotel Atlon", "Berlin, Hotel Atlon");
            // var marker = new google.maps.Marker({
            //     position: startLatLng,
            //     map: map,
            //     icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
            //     title: "Start"
            // });

            // var marker = new google.maps.Marker({
            //     position: endLatLng,
            //     map: map,
            //     icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
            //     title: "Start"
            // });

    $.each(pois,function(index, interests)
    {
        console.log("interests:");
        console.log(interests);

        color = colors[index];
        $.each(interests[1], function(i, poi){
            // markers
            var markerLatLng = new google.maps.LatLng(poi.lat, poi.long);
            var marker = new google.maps.Marker({
                position: markerLatLng,
                map: map,
                icon: color,
                title: poi.address
            });
            var contentString = '<div class="infoWindow"><h4>'+poi.name+'</h4><p>Coordinates: '+poi.lat+','+poi.long+'<br/>Address: '+poi.address+'<br/>Avg. Duration: '+poi.duration+' minutes</p><p>'+poi.description+'</p></div>';
            var infowindow = new google.maps.InfoWindow({
                content: contentString
            });

            google.maps.event.addListener(marker, 'click', function() {
                infowindow.open(map,marker);
            });

            //waypoints
            waypoints.push({
                location: markerLatLng,
                stopover: true
             });
        });
    });
}

function codeAddress(address, title) {
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
            map: map,
            icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
            title: title,
            position: results[0].geometry.location
        });
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
}


function calcRoute() {
    // get the travelmode, startpoint and via point from the form
    // var travelMode = $('input[name="travelMode"]:checked').val();
    var travelMode = "WALKING";//DRIVING, WALKING, TRANSIT, BICYCLING
    var start = "Berlin, Brandenburger Tor";
    var end = "Berlin, Hotel Atlon"; // endpoint is a geolocation
    //var waypoints = []; // init an empty waypoints array

    pois = $('#pois').data('pois');
    console.log(pois);

    // $.each(pois,function(i, poi)
    // {
    //     waypoints.push({
    //         location: poi.lat+","+poi.long,
    //         stopover: true
    //     });
    // });


    var request = {
        origin: start,
        destination: end,
        optimizeWaypoints:true,
        waypoints: waypoints,
        unitSystem: google.maps.UnitSystem.IMPERIAL,
        travelMode: google.maps.DirectionsTravelMode[travelMode]
    };

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      $('#directionsPanel').empty(); // clear the directions panel before adding new directions
      directionsDisplay.setDirections(response);
    } else {
      // alert an error message when the route could nog be calculated.
      if (status == 'ZERO_RESULTS') {
        alert('No route could be found between the origin and destination.');
      } else if (status == 'UNKNOWN_ERROR') {
        alert('A directions request could not be processed due to a server error. The request may succeed if you try again.');
      } else if (status == 'REQUEST_DENIED') {
        alert('This webpage is not allowed to use the directions service.');
      } else if (status == 'OVER_QUERY_LIMIT') {
        alert('The webpage has gone over the requests limit in too short a period of time.');
      } else if (status == 'NOT_FOUND') {
        alert('At least one of the origin, destination, or waypoints could not be geocoded.');
      } else if (status == 'INVALID_REQUEST') {
        alert('The DirectionsRequest provided was invalid.');
      } else {
        alert("There was an unknown error in your request. Requeststatus: nn"+status);
      }
    }
  });
}