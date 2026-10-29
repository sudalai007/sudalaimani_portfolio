import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(const ContactState()) {
    on<ContactFormSubmitted>(_onContactFormSubmitted);
    on<ContactFormReset>(_onContactFormReset);
  }

  Future<void> _onContactFormSubmitted(
    ContactFormSubmitted event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(status: ContactStatus.loading));

    final msg = event.message;
    if (msg.name.trim().isEmpty ||
        msg.email.trim().isEmpty ||
        msg.message.trim().isEmpty) {
      emit(state.copyWith(
        status: ContactStatus.failure,
        errorMessage: 'Please fill in all required fields.',
      ));
      return;
    }

    // Simulate validation and dispatch prep
    await Future.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(
      status: ContactStatus.success,
      successMessage:
          'Thank you, ${msg.name}! Your message is prepared and your mail client will open to send it.',
    ));
  }

  void _onContactFormReset(
    ContactFormReset event,
    Emitter<ContactState> emit,
  ) {
    emit(const ContactState(status: ContactStatus.initial));
  }
}

