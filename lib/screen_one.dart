import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  void initState() {
    _listenCode();
    super.initState();
  }

  final controller = TextEditingController();
  bool isOtpSent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login with your Mobile number", style: buildTextStyle(18)),
            const SizedBox(height: 60),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: const OutlineInputBorder(),
                  labelText: "Mobile Number",
                  labelStyle: buildTextStyle(15)),
            ),
            if (isOtpSent == true) const SizedBox(height: 40),
            if (isOtpSent == true)
              TextFieldPinAutoFill(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: const OutlineInputBorder(),
                    labelText: "OTP",
                    labelStyle: buildTextStyle(15)),
                codeLength: 4,
                onCodeChanged: (val) {
                  debugPrint("on code submit $val");
                },
              ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () async {
                final signatureCode = await SmsAutoFill().getAppSignature;
                debugPrint("signatureCode :: $signatureCode");
                setState(() {
                  isOtpSent = !isOtpSent;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: const Color(0xff2d60aa),
                ),
                child: const Text(
                  "SEND OTP",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle buildTextStyle(double fontSize) => TextStyle(
      color: const Color(0xff2d60aa),
      fontSize: fontSize,
      fontWeight: FontWeight.w500);

  void _listenCode() async {
    await SmsAutoFill().listenForCode();
  }
}
