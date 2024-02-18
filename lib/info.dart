import 'package:flutter/material.dart';
import 'package:uasdantugasbesarariksaputra/add_page.dart';
import 'package:uasdantugasbesarariksaputra/main.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://i.scdn.co/image/ab6761610000517429ec9d388f7d0f9b3480f316'), // Ganti dengan URL avatar yang diinginkan
            ),
            SizedBox(height: 20),
            Text(
              'Nama: Arik Saputra Misnanto',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Kelas: TIF221PA',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'NPM: 21552011119',
              style: TextStyle(fontSize: 18),
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
          currentIndex: 2, // Set index untuk item yang sedang dipilih (Info)
          selectedItemColor: Colors.blue,
          onTap: (index) {
            // Navigasi sesuai dengan index yang dipilih
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
                break;
              case 2:
                // Tidak perlu navigasi karena sudah berada di halaman Info
                break;
            }
          },
        ),
      ),
    );
  }
}
