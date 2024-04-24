import 'dart:convert';

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
      'amount': '5000',
      'currency': "USD",
      'confirm' : "false",
    },
  );

  final paymentIntent = jsonDecode(response.body);

  final confirmResult = await Stripe.instance.confirmPayment(
    paymentIntentClientSecret: 
    paymentIntent!['client_secret'],
    data: const PaymentMethodParams.cardFromMethodId(paymentMethodData: 
    PaymentMethodDataCardFromMethod(paymentMethodId: "pm_card_visa")), // You may need to specify a payment method
  );
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
