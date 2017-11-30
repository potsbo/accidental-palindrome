var typingTimer;                //timer identifier
var doneTypingInterval = 100;  //time in ms, 5 second for example
var $input = $('#query');

$input.on('keyup', function () {
  clearTimeout(typingTimer);
  typingTimer = setTimeout(doneTyping, doneTypingInterval);
});

$input.on('keydown', function () {
  clearTimeout(typingTimer);
});

function doneTyping () {
  $.post("https://accidental-palindrome.herokuapp.com/find", { // TODO: make this configuable
    text: $('#query').val()
  }, function(data) {
    console.log(data)
    $("#text").html(data.text);
    $("#longest").html(data.longest_palindrome.surface);
    $("#pronounce").html(data.longest_palindrome.pronounce)
    $("#length").html(data.longest_palindrome.size)
  });
}
