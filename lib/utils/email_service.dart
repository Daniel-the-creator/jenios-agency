import 'dart:convert';
import 'package:http/http.dart' as http;

/// EmailJS configuration — fill these in after creating your free account at
/// https://www.emailjs.com
///
/// Steps:
///  1. Sign up at emailjs.com (free tier sends 200 emails/month)
///  2. Add a Gmail service and connect Jeniousagency@gmail.com
///  3. Create an email template — use these variables in the template body:
///       {{from_name}}, {{from_email}}, {{message}}
///  4. Copy your Service ID, Template ID, and Public Key below.
class EmailService {
  // ─── Replace these with your actual EmailJS credentials ───────────────────
  static const String _serviceId = 'YOUR_SERVICE_ID';
  static const String _templateId = 'YOUR_TEMPLATE_ID';
  static const String _publicKey = 'YOUR_PUBLIC_KEY';
  // ──────────────────────────────────────────────────────────────────────────

  static const String _apiUrl =
      'https://api.emailjs.com/api/v1.0/email/send';

  /// Sends a contact form submission to Jeniousagency@gmail.com via EmailJS.
  ///
  /// Returns `true` on success, `false` on failure.
  static Future<bool> sendContactEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost',
        },
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message,
            'to_email': 'Jeniousagency@gmail.com',
          },
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      // ignore: avoid_print
      print('EmailJS error: $e');
      return false;
    }
  }
}
