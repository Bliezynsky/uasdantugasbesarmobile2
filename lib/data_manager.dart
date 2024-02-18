import 'package:dio/dio.dart';

class DataManager {
  Future<List<Map<String, dynamic>>> fetchData() async {
    Dio dio = Dio();
    String url = 'https://65d1a4cf987977636bfb50ec.mockapi.io/mhs';
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Gagal Ambil Data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Terjadi Kesalahan: $error');
    }
  }

  Future<void> deleteData(String id) async {
    Dio dio = Dio();
    String url = 'https://65d1a4cf987977636bfb50ec.mockapi.io/mhs/$id';
    try {
      Response response = await dio.delete(url);
      if (response.statusCode == 200) {
        print('Data berhasil dihapus');
      } else {
        throw Exception('Gagal menghapus data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Terjadi Kesalahan: $error');
    }
  }
}