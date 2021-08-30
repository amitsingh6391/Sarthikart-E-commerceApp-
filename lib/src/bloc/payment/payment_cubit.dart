import 'package:fluttercommerce/src/bloc/payment/payment_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/src/bloc/payment/payment.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentCubit extends Cubit<PaymentState> {
  var _razorPay;

  PaymentCubit() : super(Idle()) {
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(num price, String phone) {
    final options = {
      'key': 'rzp_test_1iFdsz611tIZeV',
      'amount': price * 100,
      'name': 'Flutter-Commerce',
      'description': 'This is a Text Payment',
      'prefill': {
        'contact': phone,
        'email': 'fluttercommerce@gmail.com',
      },
      'external': {
        'wallets': ['paytm', "phonepe", "eCOD"]
      }
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    emit(PaymentState.paymentSuccessful(response));
    print("SUCCESS: " + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    emit(PaymentState.paymentError(response.message));
    print("ERROR: " + response.code.toString() + " - " + response.message);
//        context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    print("EXTERNAL_WALLET: " + response.walletName);
  }
}
