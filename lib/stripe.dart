import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
// import 'package:stripe_sdk/stripe_sdk.dart';

Future<void> makePayment(context) async {
  // Create a PaymentIntent with the total amount of $50
  final response = await post(
    Uri.parse('https://api.stripe.com/v1/payment_intents'),
    headers: {
      'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'amount': '3000',
      'currency': "USD",
      'confirm': "false",
      "capture_method": "manual"},
  );

  final paymentIntent = jsonDecode(response.body);

  log(paymentIntent.toString());

  ClientSecret.key = paymentIntent!['id'];

  await Stripe.instance.confirmPayment(
    paymentIntentClientSecret: paymentIntent!['client_secret'],
    data: const PaymentMethodParams.cardFromMethodId(
      paymentMethodData: PaymentMethodDataCardFromMethod(paymentMethodId: "pm_card_visa"),
    ), // You may need to specify a payment method
  );
}

Future<void> captureAmmount() async {
  // Create a PaymentIntent with the total amount of $50
  final response = await post(
    Uri.parse('https://api.stripe.com/v1/payment_intents/pi_3P9UitIjZ8B0oecy2ZwVmpwo/capture'),
    headers: {
      'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'amount_to_capture': '2000'},
  );

  final paymentIntent = jsonDecode(response.body);
  await Stripe.instance.confirmPayment(
    paymentIntentClientSecret: paymentIntent!['client_secret'],
    data: const PaymentMethodParams.cardFromMethodId(
      paymentMethodData: PaymentMethodDataCardFromMethod(paymentMethodId: "pm_card_visa"),
    ), // You may need to specify a payment method
  );



  /*final url = "https://api.stripe.com/v1/payment_intents/${ClientSecret.key}/capture";

  log("${ClientSecret.key}");

  log(url);

  log("Bearer ${dotenv.env['STRIPE_SECRET']}");

  final response = await post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    // body: {'amount_to_capture': '5000', 'currency': "USD"},
  );

  log(response.body);*/
}

class ClientSecret {
  static late String key;
}



// Future<void> makePayment({required String amount}) async {
//   try {
//     final response = await post(
//       Uri.parse('https://api.stripe.com/v1/payment_intents'),
//       headers: {
//         'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'amount': amount,
//         'currency': "USD",
//       },
//     );

//     final paymentIntent = jsonDecode(response.body);

//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: paymentIntent!['client_secret'],
//         style: ThemeMode.dark,
//         merchantDisplayName: "Muhammad Haris",
//       ),
//     );

//     await Stripe.instance.presentPaymentSheet();
//   } catch (e) {
//     log("Error: $e");
//   }
// }
