const {get, data } = require("jquery");

$(document).ready(function() {

    // if (window.navigator.geolocation) {
    // window.navigator.geolocation.window.navigator.geolocation.getCurrentPosition(console.log, console.log);
    // }
    // $.getJSON("http://freegeoip.net/json/", function(data) {
    //     var country_code = data.country_code;
    //     var country = data.country_name;
    //     var ip = data.ip;
    //     var time_zone = data.time_zone;
    //     var latitude = data.latitude;
    //     var longitude = data.longitude;

    //     alert("Country Code: " + country_code);
    //     alert("Country Name: " + country);
    //     alert("IP: " + ip);
    //     alert("Time Zone: " + time_zone);
    //     alert("Latitude: " + latitude);
    //     alert("Longitude: " + longitude);
    // });

    var options = { enableHighAccuracy: true, timeout: 5000, maximumAge: 0 };

    function success(pos) {
        var crd = pos.coords;
        console.log('Votre position actuelle est :');
        console.log(`Latitude : ${crd.latitude}`);
        console.log(`Longitude : ${crd.longitude}`);
        console.log(`La précision est de ${crd.accuracy} mètres.`);
        console.log(crd);
        $.ajax({
            type: "get",
            url: "/structures.json",
            data: { l: crd.latitude, L: crd.longitude },
            success: function(data) {
                var rows = ""
                data.forEach(function(i) {
                    rows += ` < tr > < td > $ { i.name } < /td> <td> ${i.opening_hours ? "Open" : "Close"} </td > < td > $ { i.rating } < /td> </tr > `
                    $("#display").html(rows)
                    console.log(i)
                })
            }
        })
    }

    function error(err) { console.warn(`
                        ERREUR($ { err.code }): $ { err.message }
                        `); }
    navigator.geolocation.getCurrentPosition(success, error, options);
})