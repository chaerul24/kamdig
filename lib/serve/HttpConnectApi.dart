import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kamdig/model/NewsModel.dart';

class Httpconnectapi {
  final String apiUrl = "https://kamdig.chaerul.biz.id/";

  // Contoh GET
  Future<dynamic> getData(String endpoint) async {
    final response = await http.get(Uri.parse('$apiUrl$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  // Khusus untuk upload file (multipart)
  Future<dynamic> uploadFile(String endpoint, String filePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl$endpoint'),
      );
      request.files.add(await http.MultipartFile.fromPath('image', filePath));

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseData;
      } else {
        throw HttpException(responseData['message'] ?? 'Gagal upload file');
      }
    } catch (e) {
      throw HttpException('Upload error: ${e.toString()}');
    }
  }

  // Contoh POST
  Future<Map<String, dynamic>> postFormData(
    String endpoint,
    Map<String, String> fields,
  ) async {
    try {
      var uri = Uri.parse('$apiUrl$endpoint');
      var request = http.MultipartRequest('POST', uri);

      // Tambahkan semua field ke form-data
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      // Kirim request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: $responseBody');
        return jsonDecode(responseBody);
      } else {
        print('Error Response: $responseBody');
        throw Exception('Gagal kirim data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during form-data POST request: $e');
      throw Exception('Error during POST request: ${e.toString()}');
    }
  }

  Future<List<NewsModel>> getNews() async {
    final rawData = await getData('api/v1/news');
    final Map<String, dynamic> data = rawData['data'];

    return data.entries.map((entry) {
      return NewsModel.fromJson(entry.key, entry.value);
    }).toList();
  }

  Future<NewsModel> openArticle(String id) {
    return getData('api/v1/news/$id').then((rawData) {
      final Map<String, dynamic> data = rawData['data'];
      return NewsModel.fromJson(id, data);
    });
  }
}
