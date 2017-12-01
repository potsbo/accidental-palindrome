var typingTimer;                //timer identifier
var doneTypingInterval = 100;  //time in ms, 5 second for example
var $input = $('#query');

function doneTyping() {
  $.post("https://accidental-palindrome.herokuapp.com/find", { // TODO: make this configuable
    text: $('#query').val()
  }, function(data) {
    $("#text").html(data.text);
    $("#longest").html(data.longest_palindrome.surface || 'ー');
    $("#pronounce").html(data.longest_palindrome.pronounce || 'ー');
    $("#length").html(data.longest_palindrome.size);
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
