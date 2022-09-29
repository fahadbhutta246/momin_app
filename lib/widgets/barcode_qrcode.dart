
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';


class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({Key? key}) : super(key: key);

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {

  String? barResult;
  String? qrResult;

  Future barCodeScanner() async {
    String result;
    var status = await Permission.camera.status;
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "#FFBF00", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      result = "Failed to get platform version";
    }
    if (status.isGranted) {
      return
      setState(() {
        barResult = result;
      });
    }
    else{
      barResult = (await Permission.camera.status) as String?;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: MaterialButton(
                  onPressed: barCodeScanner,
                  color: Colors.blueAccent,
                  shape: const StadiumBorder(),
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt_outlined,),
                      SizedBox(width: 5.0,),
                      Text("Scan Barcode", style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                barResult == null ? "Scan a Code" : "Scan Result is : $barResult",  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}