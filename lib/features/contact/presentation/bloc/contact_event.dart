import 'package:equatable/equatable.dart';
import '../../domain/entities/contact_message.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

class ContactFormSubmitted extends ContactEvent {
  final ContactMessage message;

  const ContactFormSubmitted(this.message);

  @override
  List<Object?> get props => [message];
}

class ContactFormReset extends ContactEvent {
  const ContactFormReset();
}

