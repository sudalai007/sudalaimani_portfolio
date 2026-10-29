import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../domain/entities/contact_message.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contact_state.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final message = ContactMessage(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        subject: _subjectController.text.trim().isEmpty
            ? AppConstants.emailSubject
            : _subjectController.text.trim(),
        message: _messageController.text.trim(),
      );
      context.read<ContactBloc>().add(ContactFormSubmitted(message));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocConsumer<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // Trigger mailto client with prefilled fields
          final subject = _subjectController.text.trim().isEmpty
              ? AppConstants.emailSubject
              : _subjectController.text.trim();
          final body =
              'Name: ${_nameController.text.trim()}\nEmail: ${_emailController.text.trim()}\n\nMessage:\n${_messageController.text.trim()}';

          UrlHelper.launchEmail(
            context: context,
            email: AppConstants.email,
            subject: subject,
            body: body,
          );
        }
      },
      builder: (context, state) {
        if (state.isSuccess) {
          return GlassContainer(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    size: 36,
                    color: AppColors.accentGreen,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Message Prepared!',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  state.successMessage ??
                      'Your email application has been invoked to send the message directly to Sudalaimani V.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _nameController.clear();
                    _emailController.clear();
                    _subjectController.clear();
                    _messageController.clear();
                    context.read<ContactBloc>().add(const ContactFormReset());
                  },
                  child: const Text('Send Another Message'),
                ),
              ],
            ),
          );
        }

        return GlassContainer(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Send Direct Message',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Fill out the form below to dispatch an email inquiry directly.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 20),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    hintText: 'e.g. John Doe',
                    prefixIcon: Icon(Icons.person_outline, size: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address *',
                    hintText: 'e.g. john@example.com',
                    prefixIcon: Icon(Icons.email_outlined, size: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Subject Field
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    hintText: 'e.g. Mobile App Development Project',
                    prefixIcon: Icon(Icons.label_outline, size: 20),
                  ),
                ),
                const SizedBox(height: 16),

                // Message Field
                TextFormField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Your Message *',
                    hintText: 'Describe your project requirements or inquiry...',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your message';
                    }
                    if (value.trim().length < 10) {
                      return 'Message must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                if (state.isFailure && state.errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accentRose.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.accentRose.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      state.errorMessage!,
                      style: const TextStyle(
                        color: AppColors.accentRose,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Submit Button
                GradientButton(
                  label: state.isLoading ? 'Sending...' : 'Send Message',
                  icon: state.isLoading ? null : Icons.send_rounded,
                  onPressed: state.isLoading ? null : _submit,
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

