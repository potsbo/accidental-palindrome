var typingTimer;
var doneTypingInterval = 100; // ms
var $input = $('#query');

function doneTyping() {
  // $.post("https://accidental-palindrome.herokuapp.com/find", { // TODO: make this configurable
  $.post("http://localhost:3000/find", { // TODO: make this configurable
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
