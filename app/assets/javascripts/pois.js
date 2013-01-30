// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){
    initialize();
    calcRoute();
});

var directionDisplay;
var directionsService = new google.maps.DirectionsService();
function initialize() {
    var latlng = new google.maps.LatLng(51.764696,5.526042);
    // set direction render options
    var rendererOptions = { draggable: true };
    directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
    var myOptions = {
        zoom: 14,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false
    };
    // add the map to the map placeholder
    var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
    directionsDisplay.setMap(map);
    directionsDisplay.setPanel(document.getElementById("directionsPanel"));
    // Add a marker to the map for the end-point of the directions.
    var marker = new google.maps.Marker({
        position: latlng,
        map: map,
        title:"Rodderhof, Oss"
    });
}

function calcRoute() {
    // get the travelmode, startpoint and via point from the form
    var travelMode = $('input[name="travelMode"]:checked').val();
    var start = $("#routeStart").val();
    var via = $("#routeVia").val();

    if (travelMode == 'TRANSIT')
    {
        via = ''; // if the travel mode is transit, don't use the via waypoint because that will not work
    }
    var end = "51.764696,5.526042"; // endpoint is a geolocation
    var waypoints = []; // init an empty waypoints array
    if (via != '')
    {
        // if waypoints (via) are set, add them to the waypoints array
        // waypoints.push({
        //   location: via,
        //   stopover: true
        // });
        //waypoints.push({optimize:true});

        var pois = $('#pois').data('pois');
        console.log(pois);
        var geoLoc;
        // console.log(pois.count);
        $.each(pois,function(i, poi)
        {
            // console.log(poi);
            geoLoc = ""+poi.lat+","+poi.long+"";
            waypoints.push({
                location: geoLoc,
                stopover: true
            });
            // console.log(waypoints);
        });

        // $.each(pois[1],function(i, poi)
        // {
        //     // console.log(i);
        //     geoLoc = ""+poi.lat+","+poi.long+"";
        //     waypoints.push({
        //         location: geoLoc,
        //         stopover: true
        //     });
        //      // console.log(waypoints);
        // });

        // var start = pois[0].lat + "," + pois[0].long;
        // var end = pois[pois.length-1].lat + "," + pois[pois.length-1].long;// endpoint is a geolocation
    }

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