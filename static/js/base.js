$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip(); 
    $('[data-toggle="confirmation"]').confirmation();
    
    $('#sidebar-toogle').on('click', function () {
        $('#sidebar').toggleClass("active", checkSidebarCookie());
    });

    setNavigation();
});

function setNavigation() {
    var path = window.location.pathname;
    path = path.replace(/\/$/, "");
    path = decodeURIComponent(path);

    $("#sidebar a").each(function () {
        var href = $(this).attr('href');
        if (path.substring(0, href.length) === href) {
            $(this).closest('li').addClass('active');
        }
    });
}

function checkSidebarCookie() {
    var toogle = getCookie("sidebar");
    if (toogle == "") {
        toogle = "active";
    } else {
        toogle = "";
    }

    setCookie("sidebar", toogle, 365);
    return toogle === "active";
}

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}