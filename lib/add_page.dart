import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:uasdantugasbesarariksaputra/info.dart';
import 'package:uasdantugasbesarariksaputra/main.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late TextEditingController _nameController;
  late TextEditingController _npmController;
  late TextEditingController _classController;
  late TextEditingController _majorController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _npmController = TextEditingController();
    _classController = TextEditingController();
    _majorController = TextEditingController();
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
        title: const Text('Tambah Mahasiswa'),
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
                final Map<String, dynamic> newData = {
                  'nama': _nameController.text,
                  'npm': _npmController.text,
                  'kelas': _classController.text,
                  'jurusan': _majorController.text,
                };

                // Kirim data baru ke API
                await addData(newData);

                // Kosongkan field setelah data berhasil ditambahkan
                _nameController.clear();
                _npmController.clear();
                _classController.clear();
                _majorController.clear();
              },
              child: const Text('Tambah Mahasiswa'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info',
            ),
          ],
          currentIndex: 1, // Set index untuk item yang sedang dipilih (Info)
          selectedItemColor: Colors.blue,
          onTap: (index) {
            // Handle tapping on the navigation items here
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
              case 1:
                // Stay on the current page (AddPage)
                break;
              case 2:
                // Navigate to the info page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => InfoPage()),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}

// Fungsi untuk mengirim permintaan HTTP ke API untuk menambahkan data baru
Future<void> addData(Map<String, dynamic> newData) async {
  try {
    Dio dio = Dio();
    String url = 'https://65d1a4cf987977636bfb50ec.mockapi.io/mhs';
    // Kirim permintaan POST ke API dengan data baru
    await dio.post(url, data: newData);
    print('Data berhasil ditambahkan');
  } catch (error) {
    print('Terjadi kesalahan saat menambahkan data: $error');
  }
}
