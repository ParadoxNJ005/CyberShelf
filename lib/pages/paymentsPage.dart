import 'package:flutter/material.dart';
import 'package:opinionx/components/custom_helpr.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    try {
      razorpay.clear();
    } catch (e) {
      print(e);
    }
    super.dispose(); // Call super.dispose() after clearing razorpay
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Pay 1 rupee"),
          onPressed: () {
            var options = {
              'key': 'rzp_test_GcZZFDPPOjHtC4',
              'amount': 100, // Amount in paise (1 rupee = 100 paise)
              'name': 'Naitik Jain',
              'description': 'Fine Parth',
              'prefill': {
                'contact': '7248119726',
                'email': 'n@gmail.com'
              }
            };

            try {
              razorpay.open(options);
            } catch (e) {
              print('Error: $e');
            }
          },
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Dialogs.showSnackbar(context, "Payment Done: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Dialogs.showSnackbar(context, "Payment Failed: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Dialogs.showSnackbar(context, "External Wallet: ${response.walletName}");
  }
}
