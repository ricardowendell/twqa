$(document).ready(function() {

	var numberOfQuestionsToAsk = 3;
	var questionsData;
	var timer = new Timer();
	var attemptedQuestionsLog = new Array();

	$('#clock').addClass("hidden").removeClass("playing");

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
							"<div class='question hidden' data-id='{{question_id}}'>" +
								"<h2 class='question_text'>Q" + (index+1) + ": {{question}}</h2>" +
								"<ol class='choices'>" +
									"{{#choices}}" +
									"<li class='choice'>" +
										"<a href='#' class='answer'>{{.}}</a>" +
									"</li>" +
									"{{/choices}}" +
								"</ol>" +
								"<div class='correct_answer hidden'>{{correct_choice}}</div>" +
							"</div>";

			var question = Mustache.to_html(template, item);
			$("#questions").append(question);
		});
	}

	function play() {
		$("#win, #lose, #alert-actions").addClass("hidden");
		attemptedQuestionsLog = [];
		$('#clock').removeClass("hidden").addClass("playing")
		renderQuestions(questionsData, numberOfQuestionsToAsk);
		timer.start();
		ask($(".question").first(), 0, 0);
	}


	function ask(question, questionsAsked, score) {
		if (questionsAsked === numberOfQuestionsToAsk) {
			mark(score);
			attemptedQuestion();
		} else {
			question.removeClass("hidden");
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

			question.addClass("hidden");
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
			$("#win").removeClass("hidden");
			$('#clock').removeClass("playing");
		} else {
			$("#lose").removeClass("hidden");
			displayScore(score);
			$('#clock').addClass("hidden").removeClass("playing");
		}

		$("#alert-actions").removeClass("hidden");
	}

	function displayScore(score) {
			var lose_result =
				"You have answered " + score +
				" out of " + numberOfQuestionsToAsk + " question(s) correctly.";

			$("#lose_result").text(lose_result);
	}

	function correct_attempt(question) {
		hash_data = {"question_id" : question.data("id"),
			  "answered_correctly" : true};

		attemptedQuestionsLog.push(hash_data);
	}

	function incorrect_attempt(question) {
		hash_data = {"question_id" : question.data("id"),
			  "answered_correctly" : false};

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
