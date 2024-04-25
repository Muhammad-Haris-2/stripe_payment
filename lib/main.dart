import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/stripe.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_test_51OgiyYIjZ8B0oecyIZsQqNYSjIpxAhjnjUzTtU9tmWRSZf5fm1qo97mEIC6xPKVZ6g2yoVeQoN03bGMz0sWS0pOm008nXDiFR5";

  // // Initialize Stripe SDK with your publishable key
  // Stripe.init('pk_test_51P98A0DN0hTVBXb21JKwX9LjYntyOTArbbvZ6Wej3gzem1jThzWdLTSngvHvQGDHkD9wUZVuwSpfuO69oPgKHa3d0032bRTIzw');

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Testing"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                makePayment(context);
              },
              child: const Text("Payment"),
            ),

            ElevatedButton(
              onPressed: () {
                captureAmmount();
              },
              child: const Text("Capture"),
            ),
          ],
        ),
      ),
    );
  }
}
