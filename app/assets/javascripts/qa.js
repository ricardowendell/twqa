$(document).ready(function() {

  var numberOfQuestionsToAsk = 3;
  var questionsData;
  var timer = new Timer();
  var attemptedQuestionsLog = new Array();

  $('#clock').hide();
  setInterval(function() {
    $('#clock').text( timer.formatMilliseconds() )
  }, 0);

  function loadQuestions(callBack) {
    $.get("/questions/questions.json", function(data) {
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
                      "<div class='question_id'>{{question_id}}</div>" +
                      "<div class='question_text'>Q" + (index+1) + ": {{question}}</div>" +
                      "<div class='options'>" +
                      "<ol class='choices'>" +
                      "{{#choices}}" +
                      "<li class='choice'>" +
                      "<a href='#' class='btn answer'><span>{{.}}</span></a>" +
                      "</li>" +
                      "{{/choices}}" +
                      "</ol>" +
                      "</div>" +
                      "<div class='correct_answer'>{{correct_choice}}</div>" +
                      "</div>";

      var question = Mustache.to_html(template, item);
      $("#questions").append(question);
      $('li.choice').each(function(index) {
        $(this).find('a').addClass("btn answer" + (index+1)%2 );
      });
    });
  }

  function play() {
    $("#win").hide();
    $("#lose").hide();
	$("#alert-actions").hide();
    attemptedQuestionsLog = [];
 	$('#clock').show();
    renderQuestions(questionsData, numberOfQuestionsToAsk);
	timer.start();
    ask($(".question").first(), 0, 0);
  }


  function ask(question, questionsAsked, score) {
    if (questionsAsked === numberOfQuestionsToAsk) {
      mark(score);
      attemptedQuestion();
    } else {
      question.toggle();
    }

    question.on("click", ".choices a", function(event) {
      var chosenAnswer = $(this).text();
      var correctAnswer = question.find(".correct_answer").text();

      if (chosenAnswer === correctAnswer) {
        score += 1;
        correct_attempt(question);
      }
      else {
        incorrect_attempt(question);
      }

      question.toggle();
      ask(question.next(), questionsAsked += 1, score);
    });
  }

  function mark(score) {
    timer.stop();
    if (score === numberOfQuestionsToAsk) {
	  $.post('/timers/'+$('#player_id').text()+'/record',{time_seconds:timer.elapsedSeconds()})
		.success(function() {
			$.get('/leaderboard/player_position/'+$('#player_id').text(), function(data) {
				$('#leaderboard-position').text('Your leaderboard position is #' + data)
			});
		});
      $("#win").toggle();
    } else {
      $("#lose").toggle();
      displayScore(score);
      $('#clock').hide();
    }
	$("#alert-actions").toggle();
  }

  function displayScore(score) {
      var lose_result =
        "You have answered " + score +
        " out of " + numberOfQuestionsToAsk + " question(s) correctly.";

      $("#lose_result").text(lose_result);
  }

  function correct_attempt(question) {
    hash_data = {"question_id":question.find(".question_id").text(),
                 "answered_correctly":true};
    attemptedQuestionsLog.push(hash_data);
  }

  function incorrect_attempt(question) {
    hash_data = {"question_id":question.find(".question_id").text(),
                 "answered_correctly":false};
    attemptedQuestionsLog.push(hash_data);
  }

  function attemptedQuestion () {
	  $.post('/attempted_questions/'+$('#player_id').text()+'/record', {attempted_questions:attemptedQuestionsLog});
  }

  $("#alert-actions a:nth-child(1)").on("click", function(event) {
    play();
  });

  loadQuestions(play);
});
