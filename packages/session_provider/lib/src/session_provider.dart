import 'package:session_provider/session_provider.dart';

/// {@template session_provider}
/// Provides an abstraction for User session retrieval.
/// {@endtemplate}
abstract class SessionProvider {
  /// {@macro session_provider}
  const SessionProvider();

  /// Fetches the current [UserSession].
  ///
  /// Returns [UserSession.invalid] in case there is no session or if the
  /// existing is not valid.
  Future<UserSession> fetchSession();

  Future<void> saveUserSession(UserSession session);

  Future<void> clearSession();
}
