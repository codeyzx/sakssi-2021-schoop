import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/models/transaction_model.dart';
import 'package:schoop/services/services.dart';
import 'package:schoop/ui/schoop/activity/successreturn_page_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart';

class ScannerReturn extends StatefulWidget {
  final String idTransaction;
  final bool isLate;
  final TransactionModel transaction;
  const ScannerReturn({
    Key? key,
    required this.idTransaction,
    required this.isLate,
    required this.transaction,
  }) : super(key: key);
  @override
  _ScannerReturnState createState() => _ScannerReturnState(
        this.idTransaction,
        this.isLate,
        this.transaction,
      );
}

class _ScannerReturnState extends State<ScannerReturn> {
  final String _idTransaction;
  final bool _isLate;
  final TransactionModel _transaction;

  _ScannerReturnState(
    this._idTransaction,
    this._isLate,
    this._transaction,
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
        print(barcode.code);
        if (_isLate == true) {
          if (barcode.code == 'RETURN CHARGE') {
            print('MASUKKKKKKKKKKKK RETURN CHARGE');
            controller.stopCamera();
            HapticFeedback.vibrate();

            await TransactionServices.returnTransaction(
                _transaction, _idTransaction);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return SuccessReturnPage();
            }));
          } else {
            print('KOK GAK MASUKKKKKKKKKKKKKKKKKKKKKK');
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
              Navigator.of(context).pop();
            });
          }
        } else {
          if (barcode.code == 'RETURN BOOK') {
            print('MASUKKKKKKKKKKKK RETURN BOOK');
            controller.stopCamera();
            HapticFeedback.vibrate();

            await TransactionServices.returnTransaction(
                _transaction, _idTransaction);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return SuccessReturnPage();
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
        }
      });
    });
  }
}
