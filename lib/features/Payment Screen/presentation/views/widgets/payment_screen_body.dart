import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Payment%20Screen/presentation/manager/bloc/payment_bloc.dart';
import 'package:edunourish/features/Payment%20Screen/presentation/manager/bloc/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../manager/bloc/payment_event.dart';

// Define the custom colors

const Color myBlackColor = Color(0xff1A1A1A);
const Color redWarning = Colors.red;

class PaymentScreenBody extends StatefulWidget {
  const PaymentScreenBody({super.key});

  @override
  State<PaymentScreenBody> createState() => _PaymentScreenBodyState();
}

class _PaymentScreenBodyState extends State<PaymentScreenBody> {
  final TextEditingController _amountController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  _processPayment() {
    final text = _amountController.text.trim();
    setState(() => _errorText = null);

    if (text.isEmpty) {
      setState(() => _errorText = "Amount cannot be empty");
      return;
    }

    final amount = int.tryParse(text);
    if (amount == null) {
      setState(() => _errorText = "Enter valid number");
      return;
    }

    if (amount <= 0) {
      setState(() => _errorText = "Amount must be greate than zero");
      return;
      
      
    }
    final amountInCents = (amount * 100).round();
    context
        .read<PaymentBloc>()
        .add(InitiatePaymentEvent(amount: amountInCents));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: 'Payment',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_balance_wallet,
              size: 64,
              color: ourMainColor,
            ),
            const SizedBox(height: 30),
            // Amount input field
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}')), 
              ],
              decoration: InputDecoration(
                labelText: 'Amount',
                errorText: _errorText,
                labelStyle: const TextStyle(color: ourMainColor),
                prefixIcon: const Icon(Icons.attach_money, color: ourMainColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ourMainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ourMainColor, width: 2),
                ),
                errorStyle: const TextStyle(color: Colors.red),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            // Pay button
            BlocConsumer<PaymentBloc, PaymentState>(
              listener: (context, state) {
                if (state is PaymentSuccess) {
                  _launchUrl(state.redirectUrl);
                } else if (state is PaymentFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                final isLoading = state is PaymentLoading;
                return SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ourMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledBackgroundColor: ourMainColor.withOpacity(0.6),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Pay Now',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
