import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/models/transaction_model.dart';
import 'package:schoop/services/services.dart';
import 'package:schoop/ui/library/book/successborrow_page_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart';

class Scanner extends StatefulWidget {
  final TransactionModel transaction;
  final int stok;
  final int kursi;

  const Scanner({
    Key? key,
    required this.transaction,
    required this.stok,
    required this.kursi,
  }) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState(
        this.transaction,
        this.stok,
        this.kursi,
      );
}

class _ScannerState extends State<Scanner> {
  final TransactionModel _transaction;
  final int _stok;
  final int _kursi;

  _ScannerState(
    this._transaction,
    this._stok,
    this._kursi,
  );

  final loadIndicator = Center(
    child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
    ),
  );
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
          ],
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 20,
          borderRadius: 5,
          borderColor: HexColor("#3a7bd5"),
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() async {
        this.barcode = barcode;
        if (barcode.code == 'HACKER COK') {
          print('MASUKKKKKKKKKKKK PAKKKKKKKKKKK EKOOOOOOOOOOOOOOOO');
          controller.stopCamera();
          HapticFeedback.vibrate();

          await TransactionServices.saveTransaction(
              _transaction, _stok, _kursi);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return SuccessBorrowPage();
          }));
        } else {
          print('KAGAK MASUKKKKKKKKKKKKKKKKKKKKKK');
          controller.stopCamera();
          HapticFeedback.vibrate();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'QR Code Tidak Sesuai',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              ),
            ),
          );
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
        }
      });
    });
  }
}
