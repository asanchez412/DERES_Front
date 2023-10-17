import 'package:equatable/equatable.dart';

/// {@template user_session}
/// Model representing a User session.
/// {@endtemplate}
class UserSession extends Equatable {
  /// {@macro user_session}
  const UserSession({
    required this.sessionId,
    required this.authToken,
  });

  /// Represents an invalid user session.
  static const invalid = UserSession(
    sessionId: '',
    authToken: '',
  );

  /// Return the session id.
  final String sessionId;

  /// Return the session auth token.
  final String authToken;

  /// Return whether this session is valid.
  ///
  /// A valid session has a non empty [id] and non empty [authToken]. If one of
  /// them are empty, the session will be considered as [invalid].
  bool get isValid {
    return sessionId.isNotEmpty && authToken.isNotEmpty;
  }

  /// Return whether this session is invalid.
  ///
  /// An invalid session has either [id] or [authToken] empty.
  bool get isInvalid {
    return !isValid;
  }

  @override
  List<Object> get props => [sessionId, authToken];
}
