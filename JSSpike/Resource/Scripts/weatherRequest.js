function onReadyStateChange(xhr) {
    //console.log(xhr.responseText);
    if(xhr.readyState === 4) {
        if(xhr.status === 200) {
            var response = xhr.responseText;
            var jsonObj = JSON.parse(response);
            console.log("THE WEATHER IS: " + JSON.stringify(jsonObj));
        }
    }
}

var req = new XMLHttpRequest();
req.onreadystatechange = onReadyStateChange;
req.open("GET", "http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139", true);
req.send();