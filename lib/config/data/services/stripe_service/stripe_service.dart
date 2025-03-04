import 'dart:async';
import 'dart:convert';
import 'package:e_commerce/config/data/services/constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();

  Future<void> makePayment({
    required int amount, 
    required String currency,
    required String productName
  }) async {
    String? paymentIntentClientSecret = await _createPaymentIntent(amount, currency);
    if (paymentIntentClientSecret == null) return;
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: productName, // Use product name as the display name
      ),
    );
    await processPayment();
    try {
      //=> additional logic if it is needed
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      Map<String, String> headers = {
        "Authorization": "Bearer $stripeSecretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      };
      Map<String, dynamic> body = {
        "amount": _calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card",
      };
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData["client_secret"];
      } else {
        print('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();  // Opens the Stripe payment sheet.
    } catch (e) {
      print(e.toString());
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
