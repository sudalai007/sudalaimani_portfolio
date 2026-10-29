import 'package:equatable/equatable.dart';

enum ContactStatus { initial, loading, success, failure }

class ContactState extends Equatable {
  final ContactStatus status;
  final String? errorMessage;
  final String? successMessage;

  const ContactState({
    this.status = ContactStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  bool get isLoading => status == ContactStatus.loading;
  bool get isSuccess => status == ContactStatus.success;
  bool get isFailure => status == ContactStatus.failure;

  ContactState copyWith({
    ContactStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return ContactState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage];
}

