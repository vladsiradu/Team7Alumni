var current_point ;
var latit ;
var longit ;
var map ;
var marker = null ;
var geocoder ;
var points ;
var address ;
var valign ;

	function showMapError(error)
	{
		switch(error.code) 
		{
			case error.PERMISSION_DENIED:
			alert("User denied the request for Geolocation.");
			break;
			
			case error.POSITION_UNAVAILABLE:
			alert("Location information is unavailable.");
			break;
			
			case error.TIMEOUT:
			alert("The request to get user location timed out.");
			break;
			
			case error.UNKNOWN_ERROR:
			alert("An unknown error occurred.");
			break;
		}			
	}	
		
	function populate()
	{				
		if (navigator.geolocation) 
		{ 
			navigator.geolocation.getCurrentPosition( function ( position ) 
			{  	
			
				current_point = new google.maps.LatLng( position.coords.latitude, 
												    	position.coords.longitude);	
				
				map = new google.maps.Map(document.getElementById("map_canvas"), 
				{
					center:    current_point,
					zoom: 9,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				});	
				
				
				$('#map_canvas').css({'height': '420px','width':'100%'});
		
				valign = $('#map_canvas').height() / 2 ;
			

				
				var current_position = new google.maps.Marker(
				{
					title:     "You are here",
					animation: google.maps.Animation.DROP,
					map:       map,
					position:  current_point,
				});
				
				

				var marker = new google.maps.Marker(
				{
				 	title: "Andrei Vasile",
				 	animation: google.maps.Animation.DROP,
				 	map: map,
				    position: new google.maps.LatLng(44.7623424, 25.783297300000013),
				    
				});
				
				var marker2 = new google.maps.Marker(
				{
				 	title: "Andrei Vasile",
				 	animation: google.maps.Animation.DROP,
				 	map: map,
				    position: new google.maps.LatLng(44.5623424, 26.283297300000013),
				    
				});
				var marker3 = new google.maps.Marker(
				{
				 	title: "Andrei Vasile",
				 	animation: google.maps.Animation.DROP,
				 	map: map,
				    position: new google.maps.LatLng(44.1623424, 26.08200000013),
				    
				});
				
				

// To add the marker to the map, call setMap();
marker.setMap(map);


				google.maps.event.addListener(map, 'click', function(event) 
				{
					if( marker )
					{
						marker.setMap(null);
					}
					
					marker = new google.maps.Marker(
					{
						title:		"Your Chosen Location" ,
						animation: 	google.maps.Animation.DROP ,
						map:	map,
						position: event.latLng,
						icon: "http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png"
					});
					
					points = marker.position;
					
					geocoder = new google.maps.Geocoder();
					
					geocoder.geocode({'latLng': points}, function(results, status) 
					{
						if (status == google.maps.GeocoderStatus.OK) 
						{
        					if (results[1]) 
        					{
        						address = results[1].formatted_address;
          					}
          				}
          				else
          				{
        					alert("Geocoder failed due to: " + status);
      					}
          			});
          			
          								
  				});
				
			}, showMapError , { maximumAge: 3000, timeout: 5000, enableHighAccuracy: true } ); 
			
		}
					
		

	}	
	
	
	
	$(document).ready( function() 
	{			
		populate();
	});