<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="google-signin-client_id" content="1029953614300-a63di8kgr75ipapqnsi91c0squb18r6b.apps.googleusercontent.com">
<%
	String resID = request.getParameter("resID");
    String resName = request.getParameter("resName");
    String resAddr = request.getParameter("resAddr");
    String resPhoneNum = request.getParameter("resPhoneNum");
    String resCuisine = request.getParameter("resCuisine");
    String resRating = request.getParameter("resRating");
    String resImage = request.getParameter("resImage");
    String resPhone = request.getParameter("resPhone");
%>
<link href="css/detailStyle.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="cookieTool.js"></script>
<script>
function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable) {
         	   return pair[1];
            }
    }
    return(false);
}
</script>
<script>
function addToMyFavorites() {
	var userName = getCookie("userName");
	if (userName != "Guest") {
		$.ajax({url: "FavoritesServlet", data: {resID: "<%= resID %>", userName: userName}, success: function(result){  		
		    alert("Successfully added to your favorites!");
		  }});
	} else {
		alert("Please log in to add to your favorites");
	}
}

function addToMyReservations() {
	var userName = getCookie("userName");
	if (userName != "Guest") {
		var x = document.getElementById("reservationBlock");
		if (x.style.display === "none") {
		  	x.style.display = "block";
		}
		
	} else {
		alert("Please use Google logIn to add to your reservations");
	}
}
</script>
<script>
window.onload=function() {
	var ResultsContainer = document.getElementById('results');
	var result = document.createElement('div'); 
	result.className = "row";
	var imageBlock = document.createElement('div');
	imageBlock.className = "col-md-4";
    var link = document.createElement('a');
    link.href = getQueryVariable("resUrl");
    
    var image = document.createElement('img'); 
    image.className = 'img-rounded';
    image.alt = 'Responsive image';
    var imageUrl = getQueryVariable("resImage");
    image.src = imageUrl;
    
    var infoBlock = document.createElement('div'); 
    infoBlock.className = "col-md-8";
    var address = document.createElement('h4');
    address.innerHTML = "Address: " + "<%=resAddr%>";
    var phone = document.createElement('h4');
    phone.innerHTML = "Phone: " + "<%=resPhone%>";
    var cuisine = document.createElement('h4');
    cuisine.innerHTML = "Cuisine: " + getQueryVariable("resCuisine");
    var price = document.createElement('h4');
    price.innerHTML = "Price: " + getQueryVariable("resPrice");
    var rating = document.createElement('h4');
    rating.innerHTML = "Rating: " + getQueryVariable("resRating") + " stars";
    
    link.append(image);
    imageBlock.append(link);
    result.append(imageBlock);
    
    infoBlock.append(address);
    infoBlock.append(phone);
    infoBlock.append(cuisine);
    infoBlock.append(price);
    infoBlock.append(rating);
    result.append(infoBlock);
    
    ResultsContainer.append(result);
    
    var br = document.createElement('br');
    ResultsContainer.append(br);
    
    var x = document.getElementById("reservationBlock");
    x.style.display = "none";
}
</script>
<title>Sal Eats Detail </title>
</head>
<body>
<!-- Navigation bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
<div class="container-fluid">
	<div class="navbar-header">
  		<a class="logo" href="index.html" style="text-decoration: none; color: #ab1500">SalEats!</a>
	</div>
	<ul class="nav navbar-nav navbar-right" id="navbarRight">
      		<li><a class="nav-link" href="index.html">Home</a></li>
      		<li><a class="nav-link" href="favorites.jsp">Favorites</a></li>
	</ul>
	<script type="text/javascript">
		var navbar = document.getElementById("navbarRight");
		var li = document.createElement("li");
		var userName = getCookie("userName");
		if (userName != "Guest") {
			var a = document.createElement("a");
			a.setAttribute('href', "javascript:logout();");
			a.innerHTML = "Logout";
			li.appendChild(a);
		}
		else {
			var a = document.createElement("a");
			a.setAttribute('href', "login.html");
			a.innerHTML = "Login / Sign Up";
			li.appendChild(a);
		}
		navbar.appendChild(li);
		function logout() {
			setCookie("userName", "Guest", "d1");
			var auth2 = gapi.auth2.getAuthInstance();
		    auth2.signOut().then(function () {
		      console.log('User signed out.');
		    });
			window.location='index.html';
		}
		function onLoad() {
		    gapi.load('auth2', function() {
		      gapi.auth2.init();
		    });
		}
	</script>
	<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
</div>
<hr class="dividingLine">
</nav>

<div class="container Search-container">
		<form name="searchForm" method="GET" action="searchResults.jsp">
            <div class="row">
                <div class="col-sm-6 Search-form-1">
                    <div class="form-group">
                        <input type="text" class="search-query form-control" name="searchTerm" placeholder="Search" />
                    </div>
                </div>
                <div class="col-sm-2 Search-form-1">
                    <div class="form-group">
                            <input type="submit" class="btnSubmit" id="searchIcon" value="Search" />
                    </div>
                </div>
                <div class="col-sm-2 Search-form-1">
                	<div class="form-check">
							<input class="form-check-input" type="radio" name="radio" id="bestMatch" value="best_match" checked="checked"> 
							<label class="form-check-label" for="bestMatch"> Best Match </label>
					</div>
					<div class="form-check">
							<input class="form-check-input" type="radio" name="radio" id="reviewCount" value="review_count"> 
							<label class="form-check-label" for="reviewCount"> Review Count </label>
					</div>
                </div>
                <div class="col-sm-2 Search-form-1">
                	<div class="form-check">
							<input class="form-check-input" type="radio" name="radio" id="rating" value="rating"> 
							<label class="form-check-label" for="rating"> Rating </label>
					</div>
					<div class="form-check">
							<input class="form-check-input" type="radio" name="radio" id="distance" value="distance"> 
							<label class="form-check-label" for="distance"> Distance </label>
					</div>
                </div>
             </div>
             <div class="row">
             	<div class="col-sm-4 Search-form-1">
             		<div class="form-group">
                            <input type="number" class="form-control" step=any name="latitude" id="latitude" placeholder="Latitude"/>
                	</div>
             	</div>
  				<div class="col-sm-4 Search-form-1">
  					<div class="form-group">
                            <input type="number" class="form-control" step=any name="longitude" id="longitude" placeholder="Longitude"/>
                    </div>
  				</div>
  				<div class="col-sm-4 Search-form-1">
  					<button type="button" class="btnSubmit" id="mapBtn" value="Search">
                            <span class="glyphicon glyphicon-pushpin" aria-hidden="true"></span> Google Maps (Drop a pin!)
                    </button>
				</div>
             </div>
          </form>
</div>

<div class="container Search-container">
	<div class="row">
		<h2 id="searchCap"><%= resName %></h2>
	</div>
	<hr class="dividingLine">
</div>

<div class="container Items" id="results">

</div>
<div class="container">
<div class="row">
	<div class="col-sm-12">
  		<div class="form-group">
            <input type="submit" id="favorite" class="btnSubmit" onclick="addToMyFavorites()" value="Add to Favorites" />
        </div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12">
  		<div class="form-group">
            <input type="submit" id="reservation" class="btnSubmit" onclick="addToMyReservations()" value="Add Reservation" />
        </div>
	</div>
</div>
<br>
<div id="reservationBlock">
<div class="row">
	<div class='col-sm-6'>
            <div class="form-group">
                <div class='input-group date' id='datetimepicker1'>
                    <input type='date' id='resdate' class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>
    <div class='col-sm-6'>
            <div class="form-group">
                <div class='input-group date' id='datetimepicker3'>
                    <input type='time' id='restime' class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-time"></span>
                    </span>
                </div>
            </div>
        </div>
</div>
<div class="row">
	<div class='col-sm-12'>
		<div class="form-group">
  			<textarea class="form-control" rows="5" id="notes" placeholder="Description Notes"></textarea>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12">
  		<div class="form-group">
            <input type="submit" id="submitRes" class="btnSubmit" onClick="makeReservation()" value="Submit Reservation" />
        </div>
	</div>
</div>
</div>
</div>

<button id="authorize_button" style="display: none;">Authorize</button>
<button id="signout_button" style="display: none;">Sign Out</button>

    <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '1029953614300-a63di8kgr75ipapqnsi91c0squb18r6b.apps.googleusercontent.com';
      var API_KEY = 'AIzaSyDQFn6AV28GgIle9RZdfMKnG1hL1d2jfTI';
      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];
      var SCOPES = "https://www.googleapis.com/auth/calendar";
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }
      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
          // Handle the initial sign-in state.
        }, function(error) {
          appendPre(JSON.stringify(error, null, 2));
        });
      }
      
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }
      /**
       * Print the summary and start datetime/date of the next ten events in
       * the authorized user's calendar. If no events are found an
       * appropriate message is printed.
       */
       function makeReservation(){
			var dateStr = document.getElementById('resdate').value;
			var timeStr = document.getElementById('restime').value;
			var hourStr = timeStr.substr(0, timeStr.indexOf(':'));
			var hourInt = parseInt(hourStr);
			hourInt = hourInt+1;
			var endTime = dateStr.concat('T', hourInt.toString(), ":00:00");
			var note = document.getElementById("notes").value;
			var startTime = dateStr.concat('T', timeStr, ":00");
			var resource = {
			  "summary": "Reservation at " + "<%= resName %>",
			  "location": "<%= resAddr %>",
			  "description": note,
			  "start": {
			    "dateTime": startTime,
			    "timeZone" : "America/Los_Angeles"
			  },
			  "end": {
			    "dateTime": endTime,
			    "timeZone" : "America/Los_Angeles"
			  }
			};
			var request = gapi.client.calendar.events.insert({
			  'calendarId': 'primary',
			  'resource': resource
			});
			request.execute(function(resource) {
			});
			alert("You have successfully made a reservation!");
		}
    </script>

<script async defer src="https://apis.google.com/js/api.js"
     onload="this.onload=function(){};handleClientLoad()"
     onreadystatechange="if (this.readyState === 'complete') this.onload()">
</script>

<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
	
    <div id="map" class="modal-body"><button type="button" class="close" data-dismiss="modal">&times;</button></div>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDQFn6AV28GgIle9RZdfMKnG1hL1d2jfTI&callback=initMap" async defer></script>
    	<script>
    	function initMap() {
    		var myLatlng = new google.maps.LatLng(34.02116,-118.287132);
    		var mapOptions = {
    		  zoom: 11,
    		  center: myLatlng
    		}
    		var map = new google.maps.Map(document.getElementById("map"), mapOptions);

    		// Place a draggable marker on the map
    		var myMarker = new google.maps.Marker({
    		    position: myLatlng,
    		    map: map,
    		    draggable:true,
    		    title:"Drag me!"
    		});
    		google.maps.event.addListener(myMarker, 'dragend', function(evt){
    		    document.getElementById("latitude").value = evt.latLng.lat().toFixed(6) ;
    		    document.getElementById("longitude").value = evt.latLng.lng().toFixed(6);
    		});

    		google.maps.event.addListener(myMarker, 'dragstart', function(evt){
    		    document.getElementById('current').innerHTML = '<p>Currently dragging marker...</p>';
    		});
    	}
    	
    </script>
  	</div>
  	<script>
	// Get the modal
	var modal = document.getElementById("myModal");

	// Get the button that opens the modal
	var btn = document.getElementById("mapBtn");

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];

	// When the user clicks the button, open the modal 
	btn.onclick = function() {
  	modal.style.display = "block";
	}

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
  	modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
  		if (event.target == modal) {
    		modal.style.display = "none";
  		}
	}
	</script>
</div>
</body>
</html>