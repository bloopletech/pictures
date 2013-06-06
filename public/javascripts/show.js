$(function() {  
  $("body").append('<div id="backdrop"><img id="performer"></div>');

  var backdrop = $("#backdrop");
  var performer = $("#performer");

  backdrop.click(function() {
    backdrop.hide();
    performer.removeAttr("src");
  });

  function showPerformer() {
    performer.show().css({ marginLeft: -(performer.width() / 2) + "px", marginTop: -(performer.height() / 2) + "px", "left": "50%", "top": "50%" });
  }

  performer.load(showPerformer).click(function(event) {
    if(performer.css("maxWidth") == "100%") {
      performer.css({ maxWidth: "", maxHeight: "" });
      showPerformer();

      if(performer.width() > backdrop.width()) performer.css({ "left": "0", "marginLeft": "0" });
      if(performer.height() > backdrop.height()) performer.css({ "top": "0", "marginTop": "0" });
    }
    else {
      performer.css({ maxWidth: "100%", maxHeight: "100%" });
      showPerformer();
    }

    event.stopPropagation();
  });

  $("li.picture > a").live("click", function(event) {
    performer.css({ maxWidth: "100%", maxHeight: "100%", marginLeft: "0", marginTop: "0" }).hide();
    performer.attr("src", $(this).attr("href"));
    backdrop.show();

    event.preventDefault();
  });

  $(window).resize(showPerformer);
});
