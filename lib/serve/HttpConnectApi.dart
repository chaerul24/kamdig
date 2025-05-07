import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kamdig/model/MessageModel.dart';
import 'package:kamdig/model/NewsModel.dart';

class Httpconnectapi {
  final String apiUrl = "https://kamdig.chaerul.biz.id/";
  final storage = const FlutterSecureStorage();

  // Fungsi GET
  Future<dynamic> getData(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$apiUrl$endpoint'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('GET Error: ${response.statusCode}, body: ${response.body}');
        throw HttpException('Gagal mengambil data');
      }
    } catch (e) {
      throw HttpException('GET error: ${e.toString()}');
    }
  }

  // Fungsi upload file (multipart)
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

  // Fungsi POST form-data
  Future<Map<String, dynamic>> postFormData(
    String endpoint,
    Map<String, String> fields,
  ) async {
    try {
      var uri = Uri.parse('$apiUrl$endpoint');
      var request = http.MultipartRequest('POST', uri);

      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(responseBody);
      } else {
        print('POST Error: ${response.statusCode}, body: $responseBody');
        throw Exception('Gagal kirim data');
      }
    } catch (e) {
      throw Exception('POST form-data error: ${e.toString()}');
    }
  }

  // Ambil berita
  Future<List<NewsModel>> getNews() async {
    final rawData = await getData('api/v1/news');
    final Map<String, dynamic> data = rawData['data'];

    return data.entries.map((entry) {
      return NewsModel.fromJson(entry.key, entry.value);
    }).toList();
  }

  // Buka detail berita
  Future<NewsModel> openArticle(String id) async {
    final rawData = await getData('api/v1/news/$id');
    final Map<String, dynamic> data = rawData['data'];
    return NewsModel.fromJson(id, data);
  }

  // Ambil pesan dengan token
  Future<List<MessageModel>> getMessages(String jwtToken) async {
    try {
      final response = await http
          .get(
            Uri.parse('$apiUrl/api/v1/messages'),
            headers: {'Authorization': 'Bearer $jwtToken'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> rawData = jsonDecode(response.body)['data'];
        return rawData.map((msg) => MessageModel.fromJson(msg)).toList();
      } else {
        print('GET Messages Error: ${response.statusCode}, ${response.body}');
        throw Exception('Gagal mengambil pesan');
      }
    } catch (e) {
      throw Exception('Error ambil pesan: ${e.toString()}');
    }
  }

  // Kirim pesan
  Future<Map<String, dynamic>> postMessage(
    String endpoint,
    String jwtToken,
    Map<String, dynamic> fields,
  ) async {
    try {
      var uri = Uri.parse('$apiUrl$endpoint');
      var request = http.MultipartRequest('POST', uri);

      // Tambahkan Authorization header
      request.headers['Authorization'] = 'Bearer $jwtToken';

      // Tambahkan semua fields
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Kirim request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(responseBody);
      } else {
        print(
          'POST Message Error: ${response.statusCode}, body: $responseBody',
        );
        throw Exception('Gagal kirim pesan');
      }
    } catch (e) {
      throw Exception('POST message error: ${e.toString()}');
    }
  }

  // Token management
  Future<bool> saveToken(String token) async {
    if (token.trim().isEmpty) {
      throw Exception('Token tidak boleh kosong');
    }

    try {
      await storage.write(key: 'jwt_token', value: token);
      return true;
    } catch (e) {
      print('Gagal menyimpan token: ${e.toString()}');
      return false;
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'jwt_token');
  }
}
