import 'package:equatable/equatable.dart';

/// The abstract event for phone verification reactive streams
abstract class PhoneVerificationEvent extends Equatable {
  /// The abstract event for phone verification reactive streams
  const PhoneVerificationEvent();
}

/// Signals that a verification code has been sent to [phoneNumber]
class PhoneVerificationCodeSent extends PhoneVerificationEvent {
  /// Signals that a verification code has been sent to [phoneNumber]
  const PhoneVerificationCodeSent(this.phoneNumber);

  /// The [phoneNumber] that should be recieving a verification code
  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

/// Signals that the timeout for phone verification has been reached
class PhoneVerificationTimeout extends PhoneVerificationEvent {
  /// Signals that the timeout for phone verification has been reached
  const PhoneVerificationTimeout();

  @override
  List<Object?> get props => [];
}
