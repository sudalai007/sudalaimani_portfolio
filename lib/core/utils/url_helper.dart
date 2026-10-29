import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  UrlHelper._();

  /// Launches an external web URL in a new tab/external application safely.
  static Future<bool> launchExternal(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    try {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      try {
        return await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      } catch (_) {
        return false;
      }
    }
  }

  /// Opens default mail client using a mailto URI with fallback to clipboard.
  static Future<void> launchEmail({
    required BuildContext context,
    required String email,
    String? subject,
    String? body,
  }) async {
    final query = <String>[];
    if (subject != null && subject.isNotEmpty) {
      query.add('subject=${Uri.encodeComponent(subject)}');
    }
    if (body != null && body.isNotEmpty) {
      query.add('body=${Uri.encodeComponent(body)}');
    }

    final queryPath = query.isNotEmpty ? '?${query.join('&')}' : '';
    final emailUri = Uri.parse('mailto:$email$queryPath');

    bool launched = false;
    try {
      if (await canLaunchUrl(emailUri)) {
        launched = await launchUrl(emailUri);
      }
    } catch (_) {
      launched = false;
    }

    if (!launched && context.mounted) {
      await copyToClipboard(
        context,
        email,
        'Could not open mail app. Email copied to clipboard: $email',
      );
    }
  }

  /// Opens dialer using a tel: URI with fallback to clipboard.
  static Future<void> launchPhone({
    required BuildContext context,
    required String phone,
    required String displayPhone,
  }) async {
    final phoneUri = Uri.parse('tel:$phone');

    bool launched = false;
    try {
      if (await canLaunchUrl(phoneUri)) {
        launched = await launchUrl(phoneUri);
      }
    } catch (_) {
      launched = false;
    }

    if (!launched && context.mounted) {
      await copyToClipboard(
        context,
        displayPhone,
        'Could not launch dialer. Phone number copied to clipboard: $displayPhone',
      );
    }
  }

  /// Copies text to clipboard and displays a floating SnackBar.
  static Future<void> copyToClipboard(
    BuildContext context,
    String text,
    String feedbackMessage,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(feedbackMessage),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}

