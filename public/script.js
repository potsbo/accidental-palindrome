var typingTimer;
var doneTypingInterval = 100; // ms
var $input = $('#query');
var host = "http://localhost:3000";

function doneTyping() {
  // $.post("https://accidental-palindrome.herokuapp.com/find", { // TODO: make this configurable
  $.post(host+"/find", { // TODO: make this configurable
    text: $('#query').val()
  }, function(data) {
    $("#text").html(data.text);
    $("#longest").html(data.longest_palindrome.surface || 'ー');
    $("#pronounce").html(data.longest_palindrome.pronounce || 'ー');
    $("#length").html(data.longest_palindrome.size || 0);
  });
}

doneTyping();

$input.on('keyup', function () {
  clearTimeout(typingTimer);
  typingTimer = setTimeout(doneTyping, doneTypingInterval);
});

$input.on('keydown', function () {
  clearTimeout(typingTimer);
});


$.get(host+"/palindromes", {}, function(data){
  data.forEach(function(obj){
    $("#ranks").append("<p>"+obj.body+"</p>")
  });
});

$(function () {
  // モーダルウィンドウを開く
  function showModal(event) {
    event.preventDefault();

    var $shade = $('<div></div>');
    $shade
      .attr('id', 'shade')
      .on('click', hideModal);

    var $modalWin = $('#modalwin');
    var $window = $(window);
    var posX = ($window.width() - $modalWin.outerWidth()) / 2;
    var posY = ($window.height() - $modalWin.outerHeight()) / 2;

    $modalWin
      .before($shade)
      .css({left: posX, top: posY})
      .removeClass('hide')
      .addClass('show')
      .on('click', 'button', function () {
        hideModal();
      });
  }

  function hideModal() {
    $('#shade').remove();
    $('#modalwin')
      .removeClass('show')
      .addClass('hide');
  }

  $('.show-modal').on('click', showModal);

}());
