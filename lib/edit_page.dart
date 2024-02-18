import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditPage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _nameController;
  late TextEditingController _npmController;
  late TextEditingController _classController;
  late TextEditingController _majorController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['nama']);
    _npmController = TextEditingController(text: widget.userData['npm']);
    _classController = TextEditingController(text: widget.userData['kelas']);
    _majorController = TextEditingController(text: widget.userData['jurusan']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _npmController.dispose();
    _classController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _npmController,
              decoration: InputDecoration(labelText: 'NPM'),
            ),
            TextField(
              controller: _classController,
              decoration: InputDecoration(labelText: 'Kelas'),
            ),
            TextField(
              controller: _majorController,
              decoration: InputDecoration(labelText: 'Jurusan'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final Map<String, dynamic> updatedData = {
                  'id': widget.userData['id'],
                  'nama': _nameController.text,
                  'npm': _npmController.text,
                  'kelas': _classController.text,
                  'jurusan': _majorController.text,
                };
                
                // Kirim data yang diperbarui ke API
                await updateData(updatedData);
                
                // Kembali ke halaman utama dan kirim data yang diperbarui
                Navigator.pop(context, updatedData);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}

// Fungsi untuk mengirim permintaan HTTP ke API untuk memperbarui data
Future<void> updateData(Map<String, dynamic> updatedData) async {
  try {
    Dio dio = Dio();
    String id = updatedData['id'];
    String url = 'https://65d1a4cf987977636bfb50ec.mockapi.io/mhs/$id';
    // Kirim permintaan PUT ke API dengan data yang diperbarui
    await dio.put(url, data: updatedData);
    print('Data berhasil diperbarui');
  } catch (error) {
    print('Terjadi kesalahan saat memperbarui data: $error');
  }
}