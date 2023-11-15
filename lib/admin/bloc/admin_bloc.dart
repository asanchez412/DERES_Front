import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:topicos/admin/bloc/admin_event.dart';
import 'package:topicos/admin/bloc/admin_state.dart';
import 'package:topicos/admin/model/poll.dart';
import 'package:topicos/admin/model/question.dart';
import 'package:topicos/extensions/api.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(const AdminState.initial()) {
    on<AdminQuestionChanged>(_onAdminQuestionChanged);
    on<AdminQuestionTypeChanged>(_onAdminQuestionTypeChanged);
    on<AdminQuestionSubmitted>(_onAdminQuestionSubmitted);
    on<AdminQuestionAdd>(_onAdminQuestionAdd);
    on<AdminQuestionRequested>(_onAdminQuestionRequested);
    on<AdminEditQuestion>(_onAdminEditQuestion);
  }

  FutureOr<void> _onAdminQuestionChanged(
      AdminQuestionChanged event, Emitter<AdminState> emit) {
    emit(state.copyWith(question: event.question));
  }

  FutureOr<void> _onAdminQuestionTypeChanged(
      AdminQuestionTypeChanged event, Emitter<AdminState> emit) {
    emit(state.copyWith(questionType: event.questionType));
  }

  FutureOr<void> _onAdminQuestionSubmitted(
      AdminQuestionSubmitted event, Emitter<AdminState> emit) async {
    try {
      var client = http.Client();
      await client.fetchData(
        url: 'http://localhost:8080/addQuestion',
        headers: {
          "questions": state.question,
        },
      );
      emit(state.copyWith(status: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.failure));
    }
  }

  FutureOr<void> _onAdminQuestionAdd(
      AdminQuestionAdd event, Emitter<AdminState> emit) {
    final newQuestion = Question(
        questionText: state.question,
        type: state.questionType,
        ponderation: '0',
        id: '0');

    List<Poll> updatedPolls = [];
    for (var poll in state.poll) {
      if (poll.questionType == state.questionType) {
        List<Question> newQuestions = List.from(poll.questions)
          ..add(newQuestion);

        Poll updatedPoll =
            Poll(questions: newQuestions, questionType: poll.questionType);
        updatedPolls.add(updatedPoll);
      } else {
        updatedPolls.add(poll);
      }
    }

    emit(state.copyWith(poll: updatedPolls));
  }

  FutureOr<void> _onAdminQuestionRequested(
      AdminQuestionRequested event, Emitter<AdminState> emit) async {
    try {
      var client = http.Client();
      // final data =
      //     await client.fetchData(url: 'http://localhost:8080/getQuestions');

      // final mapQuestions = question['questions'] as List<dynamic>;
      // final listOfQuestions =
      //     mapQuestions.map((e) => Question.fromJson(e)).toList();
      final poll = _getQuestions();

      emit(state.copyWith(poll: poll));

      emit(state.copyWith(status: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.failure));
    }
  }

  FutureOr<void> _onAdminEditQuestion(
      AdminEditQuestion event, Emitter<AdminState> emit) {
    List<Poll> updatedPolls = state.poll.map((poll) {
      List<Question> updatedQuestions = poll.questions.map((question) {
        final ponderation = state.calculatePonderation();
        if (ponderation![event.questionType]! + int.parse(event.ponderation) <=
            100) {
          if (question.id == event.questionId) {
            return Question(
              questionText: question.questionText,
              type: question.type,
              ponderation: event.ponderation,
              id: question.id,
            );
          }
        }

        return question;
      }).toList();

      return Poll(
        questions: updatedQuestions,
        questionType: poll.questionType,
      );
    }).toList();

    emit(state.copyWith(poll: updatedPolls));
  }
}

List<Poll> _getQuestions() {
  final poll = [
    Poll(
      questions: [
        Question(
            questionText: '¿Recicla en su proceso productivo?',
            type: QuestionType.environmental,
            ponderation: '10',
            id: '1'),
        Question(
            questionText: '¿Realiza su logística en vehículos eléctricos?',
            type: QuestionType.environmental,
            ponderation: '10',
            id: '2'),
        Question(
            questionText:
                '¿Utiliza fuentes de energía renovable en su operación?',
            type: QuestionType.environmental,
            ponderation: '10',
            id: '3'),
        Question(
            questionText:
                '¿Tiene un programa para reducir y gestionar residuos?',
            type: QuestionType.environmental,
            ponderation: '10',
            id: '4'),
        Question(
          questionText:
              '¿Implementa prácticas de conservación de agua en sus operaciones?',
          type: QuestionType.environmental,
          ponderation: '10',
          id: '5',
        ),
      ],
      questionType: QuestionType.environmental,
    ),
    Poll(
      questions: [
        Question(
            questionText: '¿Tiene políticas de diversidad e inclusión?',
            type: QuestionType.social,
            ponderation: '10',
            id: '6'),
        Question(
            questionText:
                '¿Ofrece programas de salud y bienestar para sus empleados?',
            type: QuestionType.social,
            ponderation: '10',
            id: '7'),
        Question(
            questionText:
                '¿Proporciona oportunidades regulares de formación y desarrollo para sus empleados?',
            type: QuestionType.social,
            ponderation: '10',
            id: '8'),
        Question(
            questionText:
                '¿Se compromete a pagar salarios justos y equitativos a sus empleados?',
            type: QuestionType.social,
            ponderation: '10',
            id: '9'),
        Question(
            questionText: '¿Tiene funcionarios transgénero en su plantilla?',
            type: QuestionType.social,
            ponderation: '10',
            id: '10'),
      ],
      questionType: QuestionType.social,
    ),
    Poll(
      questions: [
        Question(
            questionText:
                '¿Tiene un código de conducta ética que deben seguir todos los empleados y directivos?',
            type: QuestionType.governance,
            ponderation: '10',
            id: '11'),
        Question(
            questionText:
                '¿Publica informes financieros de manera regular y transparente?',
            type: QuestionType.governance,
            ponderation: '10',
            id: '12'),
        Question(
            questionText:
                '¿Tiene políticas y medidas en vigor para prevenir la corrupción y el soborno?',
            type: QuestionType.governance,
            ponderation: '10',
            id: '13'),
        Question(
            questionText:
                '¿Desarrolla proyectos o iniciativas de responsabilidad social corporativa?',
            type: QuestionType.governance,
            ponderation: '10',
            id: '14'),
        Question(
            questionText: '¿Realiza su logística en vehículos eléctricos?',
            type: QuestionType.governance,
            ponderation: '10',
            id: '15'),
      ],
      questionType: QuestionType.governance,
    ),
  ];

  return poll;
}
