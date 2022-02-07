$(document).ready(function(){
  
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var curTask = 0;
  var processed = []
  function openMain() {
    $(".backgroundcolor").fadeIn(10);
  }

  function closeMain() {
    $(".backgroundcolor").css("display", "none");
  }  

  window.addEventListener('message', function(event){

    var item = event.data;
    if(item.runProgress === true) {
      openMain();

      $('#wrapper').css("width","0%");
      $(".gtadefaulttext").empty();
      $('.gtadefaulttext').append(item.name);
    }

    if(item.runUpdate === true) {

      var percent = "" + item.Length + "%"
      $('#wrapper').css("width",percent);

      $(".gtadefaulttext").empty();
      $('.gtadefaulttext').append(item.name);
    }

    if(item.closeFail === true) {
      closeMain()
      $.post('http://progress/taskCancel', JSON.stringify({tasknum: curTask}));
    }

    if(item.closeProgress === true) {
      closeMain();
    }

  });

});
