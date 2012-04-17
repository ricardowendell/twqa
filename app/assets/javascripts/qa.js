$(document).ready(function() {

  var numberOfQuestionsToAsk = 3;
  var questionsData;
  var timer = new Timer();

	//Timer experiement
  setInterval(function() {
    $('#clock').text( timer.formatMilliseconds() )
  }, 0);

  function loadQuestions(callBack) {
    $.get("questions.json", function(data) {
      questionsData = data;
      callBack();
    });
  }

  function renderQuestions(data, num) {
    $("#questions .question").remove();
    var toRender = $.shuffle(data).slice(0, num);
    $.each(toRender, function(index, item) {

      var template =
              "<div class='question'>" +
                      "<h2>{{question}}</h2>" +
                      "<div class='options'>" +
                      "<ol class='choices'>" +
                      "{{#choices}}" +
                      "<li>" +
                      "<a href='#' class='btn large primary'>{{.}}</a>" +
                      "</li>" +
                      "{{/choices}}" +
                      "</ol>" +
                      "</div>" +
                      "<div class='answer'>{{correct_choice}}</div>" +
                      "</div>";

      var question = Mustache.to_html(template, item);
      $("#questions").append(question);
    });
  }

  function play() {
    $("#win").hide();
    $("#lose").hide();
    renderQuestions(questionsData, numberOfQuestionsToAsk);
	timer.start();
    ask($(".question").first(), 0, 0);
  }


  function ask(question, questionsAsked, score) {
    if (questionsAsked === numberOfQuestionsToAsk) {
      mark(score);
    } else {
      question.toggle();
    }

    question.on("click", ".choices a", function(event) {
      var chosenAnswer = $(this).text();
      var correctAnswer = question.find(".answer").text();

      if (chosenAnswer === correctAnswer) {
        score += 1;
      }

      question.toggle();
      ask(question.next(), questionsAsked += 1, score);
    });
  }

  function mark(score) {
    timer.stop();
    if (score === numberOfQuestionsToAsk) {
	  $.post('/timers/'+$('#player_id').text()+'/record',{time_seconds:timer.elapsedSeconds()});
      $("#win").toggle();
    } else {
      $("#lose").toggle();
    }
  }

  $(".alert-actions a:nth-child(1)").on("click", function(event) {
    play();
  });

  loadQuestions(play);
});
