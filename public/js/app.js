$( document ).ready( function() {
  
  // Bind a click event to each link within the
  // essay part of the page.
  $(".essay a").click(function ( event ){ 
    // Grab link that has been clicked.
    // and find its href attribute
    // save to two variables.
    var el = $( event.target ),
        link = el.attr("href");
    // Also create a shorthand for our iframe.
    var iframe = $( ".iframe iframe");
    
    // Swap original src with link variable.
    iframe.attr("src", link);

    // Removes active classes.
    // Adds active class to link clicked.
    $("a.active").removeClass("active");
    el.addClass("active");
    
    // Prevent default link behaviour
    event.preventDefault();
    event.stopPropagation();
  });
  
});