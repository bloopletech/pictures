/*var update_files = function()
{
  $("#files .tag_list").each(function()
  {
    var div = $(this);
    div.click(function(event)
    {
      div.next().show().find(".input").focus();
      div.hide();
    });

    div.next().hide();
  });
};

$(update_files);*/

$(function()
{ 
  $(".selector li a").click(function(event) {
    event.preventDefault();
  });
  $(".selector li").click(function(event) {
    $("#" + $(this).parent().data("name")).val($(this).data("value"));
    $('#search_form').submit();
  });

/*  $("#tag_cloud_link").click(function(event)
  {
    event.preventDefault();
  });
  
  $("#tag_cloud_link").mouseenter(function(event)
  {
    $("#tag_cloud").show();
  });

  $("#tag_cloud").mouseleave(function(event)
  {
    $("#tag_cloud").hide();
  });*/

  $("#files .colorbox").colorbox({ width: 590, height: 390 });
  $("#header .colorbox").colorbox({ width: 590, height: 390 });
});
