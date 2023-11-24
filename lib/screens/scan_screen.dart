import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/constants/decorations.dart';
import 'package:nerofix/controllers/scan_controller.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/primary_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanCoupon extends StatefulWidget {
  const ScanCoupon({super.key});

  @override
  State<ScanCoupon> createState() => _ScanCouponState();
}

class _ScanCouponState extends State<ScanCoupon> {
  ScanController scanController = ScanController.access;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black.withOpacity(0.4000000059604645),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    bottom: 450,
                    child: SizedBox(
                      height: 180,
                      width: 280,
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        onPermissionSet: (ctrl, p) =>
                            _onPermissionSet(context, ctrl, p),
                        overlay: QrScannerOverlayShape(
                          overlayColor: Colors.transparent,
                          borderColor: Colors.green,
                          borderRadius: 16,
                          borderLength: 0,
                          borderWidth: 0,
                          cutOutSize: 261,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 430,
                    child: Center(
                        child: Image.asset(
                      scanBd,
                      height: 220,
                      width: 320,
                    )),
                  ),
                  Positioned(
                      bottom: 369,
                      child: RegularText(
                        text: 'Scan coupon QR code',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                  Positioned(
                      bottom: 220,
                      child: RegularText(
                        text: 'OR',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(color: AppColors.darkGray),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                decoration: Decorations.normalTextField(
                                    isValid: true,
                                    hintText: 'Enter Coupon Code'),
                              ),
                            ),
                            SizedBox(height: 22),
                            PrimaryButtonView(
                                animationId: 'animationId',
                                name: 'Submit',
                                buttonColor: AppColors.primaryGreen),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    String? lastScanData;
    scanController.qrViewController = controller;
    controller.scannedDataStream.listen((scanData) async {
      lastScanData = scanData.code;
      // if (scanData.format == BarcodeFormat.code128) {
      scanController.data.value = scanData.code!;
      controller.pauseCamera();
      await scanController.extractData();
      // }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    scanController.qrViewController?.dispose();
    super.dispose();
  }
}
