<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="google-signin-client_id" content="1029953614300-a63di8kgr75ipapqnsi91c0squb18r6b.apps.googleusercontent.com">
<link href="css/searchStyle.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="cookieTool.js"></script>
<%
    String searchTerm = request.getParameter("searchTerm");
    String latitude = request.getParameter("latitude");
    String longitude = request.getParameter("longitude");
    String radio = request.getParameter("radio");
%>
<script>
  	function createItem(resID, resName, resAddr, resUrl, resImage, resPhone, resCuisine, resPrice, resRating) {
  		var ResultsContainer = document.getElementById('results');  
        var result = document.createElement('div'); 
        result.className = "row";
        var imageBlock = document.createElement('div'); 
        imageBlock.className = "col-md-4";
        var link = document.createElement('a');
        link.href = "detail.jsp?resID="+resID+"&resName="+resName+"&resUrl="+resUrl+"&resAddr="+resAddr+"&resImage="+resImage+"&resPhone="+resPhone+"&resCuisine="+resCuisine+"&resPrice="+resPrice+"&resRating="+resRating;
        
        var image = document.createElement('img'); 
        image.className = 'img-rounded';
        image.alt = 'Responsive image';
        image.src = resImage;
        
        var infoBlock = document.createElement('div'); 
        infoBlock.className = "col-md-8";
        var name = document.createElement('h3');
        name.innerHTML = resName;
        var address = document.createElement('h4');
        address.innerHTML = resAddr;
        var url = document.createElement('h4');
        url.innerHTML = resUrl;
        
        link.append(image);
        imageBlock.append(link);
        result.append(imageBlock);
        infoBlock.append(name);
        infoBlock.append(address);
        infoBlock.append(url);
        result.append(infoBlock);
        
        ResultsContainer.append(result);
        
        var line = document.createElement('hr');
        line.className = "dividingLine";
        ResultsContainer.append(line);
        
  	}
</script>
<script>
  	window.onload=function() {
	  	$.ajax({url: "SearchServlet", data: {searchTerm: "<%= searchTerm %>", latitude: "<%= latitude %>", longitude: "<%= longitude %>", radio: "<%= radio %>"}, success: function(result){  		
		    var restaurants = JSON.parse(result).resData;
		    for (var i = 0; i < 10; i++) {
		    	createItem(restaurants[i].id, restaurants[i].name, restaurants[i].address, restaurants[i].url, restaurants[i].image, 
		    			restaurants[i].phone, restaurants[i].cuisine, restaurants[i].price, restaurants[i].rating);
		    }
		  }});
  	}
</script>
<title>Sal Eats Search Results</title>
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
		<h2 id="searchCap">Results for "<%= searchTerm %>"</h2>
	</div>
	<hr class="dividingLine">
</div>

<div class="container Items" id="results">

</div>

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