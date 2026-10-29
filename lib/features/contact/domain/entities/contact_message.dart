import 'package:equatable/equatable.dart';

class ContactMessage extends Equatable {
  final String name;
  final String email;
  final String subject;
  final String message;

  const ContactMessage({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  @override
  List<Object?> get props => [name, email, subject, message];
}

