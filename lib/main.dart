import 'package:camera/camera.dart';
import 'package:camera_qrcode_flutter/qrcode.dart';
import 'package:flutter/material.dart';

import 'camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  late final CameraDescription firstCamera;

  Future<void> camera() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera dan QR Code')),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRCode(),
                  ));
                },
                child: const Text('QR Code'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  camera();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TakePictureScreen(
                      camera: this.firstCamera,
                    ),
                  ));
                },
                child: const Text('Camera'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
