import 'dart:io';
import 'package:agri_connect/custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';

class AgriDetectionPage extends StatefulWidget {
  const AgriDetectionPage({super.key});

  @override
  State<AgriDetectionPage> createState() => _AgriDetectionPageState();
}

class _AgriDetectionPageState extends State<AgriDetectionPage> {
  File? _selectedImageFile;
  bool _isLoading = false;
  String _detectionResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.greenTextColor,
        title: Text("Agri Detection", 
               style: TextStyle(color: CustomColor.mintForestTextColor)),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.lightbulb,
                    color: CustomColor.mintForestTextColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.camera,
                    color: CustomColor.mintForestTextColor),
            onPressed: () => openQRScanner(context),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Place the plant in designated area",
              style: TextStyle(
                  color: CustomColor.ashgrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          _buildImagePreview(),
          _buildImageControls(),
          _buildDetectionResult(),
          if (_isLoading) CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _selectedImageFile != null
          ? Image.file(_selectedImageFile!, fit: BoxFit.cover)
          : Center(child: Text('No image selected')),
    );
  }

  Widget _buildImageControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.camera_alt),
          label: Text('Camera'),
          onPressed: () => _pickImage(ImageSource.camera),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.photo_library),
          label: Text('Gallery'),
          onPressed: () => _pickImage(ImageSource.gallery),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.search),
          label: Text('Detect'),
          onPressed: _detectImage,
        ),
      ],
    );
  }

  Widget _buildDetectionResult() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(_detectionResult,
          style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImageFile = File(pickedFile.path);
          _detectionResult = '';
        });
      }
    } catch (e) {
      _showError('Failed to pick image: ${e.toString()}');
    }
  }

  Future<void> _detectImage() async {
    if (_selectedImageFile == null) {
      _showError('Please select an image first');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final uri = Uri.parse('http://192.168.10.3:8000/predict');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          _selectedImageFile!.path
        ));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      setState(() {
        _detectionResult = _parseDetectionResponse(responseData);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Detection failed: ${e.toString()}');
    }
  }

  String _parseDetectionResponse(String response) {
    // Implement your response parsing logic here
    return 'Detection Result:\n$response';
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Existing QR scanner code
  void openQRScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 300,
          height: 400,
          child: MobileScanner(
            onDetect: (BarcodeCapture capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue;
                Navigator.pop(context);
                if (code != null) {
                  print('Scanned Code: $code');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}