import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

import 'package:kamdig/register.dart';
import 'package:kamdig/serve/HttpConnectApi.dart';

class OpencameraPage extends StatefulWidget {
  const OpencameraPage({super.key});

  @override
  State<OpencameraPage> createState() => _OpencameraPageState();
}

class _OpencameraPageState extends State<OpencameraPage> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  XFile? _capturedImage;
  bool _isUploading = false;
  String? _uploadError;
  bool _showPreview = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras found');
      }
      _controller = CameraController(cameras[0], ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture;
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        _uploadError = 'Gagal menginisialisasi kamera: ${e.toString()}';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final Httpconnectapi _httpConnectApi = Httpconnectapi();

  Future<void> _takePicture() async {
    if (_initializeControllerFuture == null) return;

    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() {
        _capturedImage = image;
        _showPreview = true;
      });

      // Tampilkan dialog konfirmasi
      await _showConfirmationDialog(image);
    } catch (e) {
      print("Gagal mengambil gambar: $e");
      setState(() {
        _uploadError = 'Gagal mengambil gambar: ${e.toString()}';
      });
    }
  }

  Future<void> _uploadImage(XFile image) async {
    setState(() {
      _isUploading = true;
      _uploadError = null;
    });

    try {
      final response = await _httpConnectApi.uploadFile(
        'app/uploadktp',
        image.path,
      );
      print('Upload berhasil: $response');

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterApp(imagePath: image.path),
        ),
      );
    } catch (e) {
      print("Gagal mengupload gambar: $e");
      setState(() {
        _uploadError = 'Gagal mengupload gambar: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _showConfirmationDialog(XFile image) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Foto'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Image.file(File(image.path), height: 200, fit: BoxFit.cover),
                const SizedBox(height: 20),
                const Text('Apakah foto ini sudah jelas dan sesuai?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ambil Ulang'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _showPreview = false;
                  _capturedImage = null;
                });
              },
            ),
            TextButton(
              child: const Text('Gunakan'),
              onPressed: () {
                Navigator.of(context).pop();
                _uploadImage(image);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Kamera KTP",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          _uploadError != null
              ? Center(child: Text(_uploadError!))
              : _initializeControllerFuture == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  if (!_showPreview)
                    FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CameraPreview(_controller);
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  if (_showPreview && _capturedImage != null)
                    Center(
                      child: Image.file(
                        File(_capturedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: FloatingActionButton(
                        backgroundColor:
                            _isUploading ? Colors.grey : Colors.white,
                        onPressed: _isUploading ? null : _takePicture,
                        child:
                            _isUploading
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.camera_alt, size: 30),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
