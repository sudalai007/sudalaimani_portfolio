import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudalaimani_portfolio/core/theme/app_theme.dart';
import 'package:sudalaimani_portfolio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:sudalaimani_portfolio/features/contact/presentation/widgets/contact_form.dart';

void main() {
  group('ContactForm Widget Tests', () {
    testWidgets('shows validation errors when submitted empty',
        (tester) async {
      tester.view.physicalSize = const Size(800, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final contactBloc = ContactBloc();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: BlocProvider<ContactBloc>.value(
                value: contactBloc,
                child: const ContactForm(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find the Send Message button and tap it
      final sendButton = find.text('Send Message');
      expect(sendButton, findsOneWidget);

      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      // Check validation error texts
      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your message'), findsOneWidget);

      contactBloc.close();
    });

    testWidgets('entering valid data clears validation errors and triggers submit',
        (tester) async {
      tester.view.physicalSize = const Size(800, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final contactBloc = ContactBloc();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: BlocProvider<ContactBloc>.value(
                value: contactBloc,
                child: const ContactForm(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Enter name
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name *'),
        'Alex Mercer',
      );
      // Enter email
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email Address *'),
        'alex@example.com',
      );
      // Enter message
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Your Message *'),
        'Hello, we would like to collaborate on an enterprise Flutter application.',
      );

      // Submit
      await tester.tap(find.text('Send Message'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      // Verify no validation errors
      expect(find.text('Please enter your name'), findsNothing);
      expect(find.text('Please enter your email'), findsNothing);
      expect(find.text('Please enter your message'), findsNothing);

      contactBloc.close();
    });
  });
}
