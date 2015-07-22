$(document).on 'ready cocoon:after-insert', ->

    setDefaultAppearanceToCheckedAnswers = ->
        checked_answers = $('input.quiz_questions_answers_correct[value="true"]')
        checked_answers.parents("div.answer-container").addClass("correct-answer")


    $('[data-action="toggle-correct-answer"]').on 'click', (event)->
        toggleCorrectAnswer($(event.currentTarget))

    toggleCorrectAnswer = (triggeringElement)->

        answers = triggeringElement.parents(".question-container").find("input.quiz_questions_answers_correct")
        hitten_answer = triggeringElement.siblings().find("input.quiz_questions_answers_correct")

        answers.val(false).prop('checked', false).parents("div.answer-container").removeClass("correct-answer")
        
        hitten_answer.val(true).prop('checked', true)
        hitten_answer.parents("div.answer-container").addClass("correct-answer")

    setDefaultAppearanceToCheckedAnswers()
