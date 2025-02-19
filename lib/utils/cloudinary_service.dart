import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  // Configuration values (should be stored in environment variables)
  static const String _cloudName = 'dfbhqvpmw';
  static const String _apiKey = '213546125456328';
  static const String _uploadPreset = 'your_upload_preset';
  
  // Base URL for Cloudinary uploads
  final String _cloudinaryUrl = 
    'https://api.cloudinary.com/v1_1/$_cloudName/image/upload';

  Future uploadImage({required File imageFile}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(_cloudinaryUrl))
        ..fields['upload_preset'] = "flutter-image"
        ..fields['api_key'] = _apiKey
        ..files.add(await http.MultipartFile.fromPath(
          'file', 
          imageFile.path
        ));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print("request ${request.toString()}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(responseData);
        return jsonData['secure_url'];
      }
      return null;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<List<String>> uploadMultipleImages(List<File> imageFiles) async {
    final List<String> urls = [];
    
    try {
      for (final imageFile in imageFiles) {
        final url = await uploadImage(imageFile: imageFile);
        if (url != null) urls.add(url);
      }
    } catch (e) {
      print('Error uploading multiple images: $e');
    }
    return urls;
  }

  Future<String?> uploadVideo({required File videoFile}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(_cloudinaryUrl))
        ..fields['upload_preset'] = _uploadPreset
        ..fields['api_key'] = _apiKey
        ..files.add(await http.MultipartFile.fromPath(
          'file', 
          videoFile.path
        ));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(responseData);
        return jsonData['secure_url'];
      }
      return null;
    } catch (e) {
      print('Error uploading video: $e');
      return null;
    }
  }
}