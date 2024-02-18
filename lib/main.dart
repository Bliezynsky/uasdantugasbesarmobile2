import 'package:flutter/material.dart';
import 'data_manager.dart';
import 'edit_page.dart';
import 'add_page.dart';
import 'info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> userData = [];
  bool isLoading = true;
  int selectedIndex = 0; // Variabel untuk melacak indeks menu yang dipilih

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DataManager dataManager = DataManager();
    try {
      List<Map<String, dynamic>> data = await dataManager.fetchData();
      setState(() {
        userData = data;
        isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

  void deleteData(String id) async {
    DataManager dataManager = DataManager();
    try {
      await dataManager.deleteData(id);
      fetchData();
    } catch (error) {
      print(error);
    }
  }

  void _navigateToEditPage(Map<String, dynamic> userData) async {
    final Map<String, dynamic>? updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(userData: userData),
      ),
    );

    if (updatedData != null) {
      setState(() {
        userData = updatedData;
      });
    }
    fetchData();
  }

  // Fungsi untuk menangani perubahan pada bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (selectedIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        // Navigasi ke halaman Add (add_page.dart)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddPage()),
        );
        break;
      case 2:
        // Navigasi ke halaman Info (info.dart)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InfoPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userData[index]['nama']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NPM: ${userData[index]['npm']}'),
                      Text('Kelas: ${userData[index]['kelas']}'),
                      Text('Jurusan: ${userData[index]['jurusan']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _navigateToEditPage(userData[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteData(userData[index]['id']);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}