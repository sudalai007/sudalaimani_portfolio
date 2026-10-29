import 'package:flutter_test/flutter_test.dart';
import 'package:sudalaimani_portfolio/features/contact/domain/entities/contact_message.dart';
import 'package:sudalaimani_portfolio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:sudalaimani_portfolio/features/contact/presentation/bloc/contact_event.dart';
import 'package:sudalaimani_portfolio/features/contact/presentation/bloc/contact_state.dart';

void main() {
  group('ContactBloc Tests', () {
    late ContactBloc contactBloc;

    setUp(() {
      contactBloc = ContactBloc();
    });

    tearDown(() {
      contactBloc.close();
    });

    test('initial state has ContactStatus.initial', () {
      expect(contactBloc.state.status, ContactStatus.initial);
      expect(contactBloc.state.isLoading, isFalse);
    });

    test('submitting empty fields emits failure state', () async {
      const emptyMsg = ContactMessage(
        name: '',
        email: '',
        subject: '',
        message: '',
      );

      contactBloc.add(const ContactFormSubmitted(emptyMsg));

      await expectLater(
        contactBloc.stream,
        emitsInOrder([
          const ContactState(status: ContactStatus.loading),
          predicate<ContactState>(
            (state) =>
                state.status == ContactStatus.failure &&
                state.errorMessage != null,
          ),
        ]),
      );
    });

    test('submitting valid message emits success state', () async {
      const validMsg = ContactMessage(
        name: 'Recruiter Jane',
        email: 'jane@techcorp.com',
        subject: 'Flutter Senior Opportunity',
        message: 'We are very interested in discussing opportunities.',
      );

      contactBloc.add(const ContactFormSubmitted(validMsg));

      await expectLater(
        contactBloc.stream,
        emitsInOrder([
          const ContactState(status: ContactStatus.loading),
          predicate<ContactState>(
            (state) =>
                state.status == ContactStatus.success &&
                state.successMessage != null &&
                state.successMessage!.contains('Recruiter Jane'),
          ),
        ]),
      );
    });

    test('ContactFormReset resets state to initial', () async {
      contactBloc.add(const ContactFormReset());
      await expectLater(
        contactBloc.stream,
        emits(const ContactState(status: ContactStatus.initial)),
      );
    });
  });
}

