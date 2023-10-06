import 'dart:convert';

import 'package:uts/list_data.dart';

import 'package:uts/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final namaController = TextEditingController();
  final kontakController = TextEditingController();
  final emailController = TextEditingController();

  Future postData(String nama, String kontak, String email) async {
    // print(nama);
    // String url = Platform.isAndroid
    //     ? 'http://192.168.43.244/api_flutter/index.php'
    //     : 'http://localhost/api_flutter/index.php';
    //String url = 'http://127.0.0.1/apiTrash/prosesLoginDriver.php';
    String url = 'http://10.98.5.74/uts/index.php';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody =
        '{"nama": "$nama", "kontak": "$kontak", "email": "$email"}';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Kontak'),
      ),
      drawer: const SideMenu(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: 'nama',
              ),
            ),
            TextField(
              controller: kontakController,
              decoration: const InputDecoration(
                hintText: 'kontak',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'email',
              ),
            ),
            ElevatedButton(
              child: const Text('Tambah Kontak'),
              onPressed: () {
                String nama = namaController.text;
                String kontak = kontakController.text;
                String email = emailController.text;
                // print(nama);
                postData(nama, kontak, email).then((result) {
                  //print(result['pesan']);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          //var namauser2 = namauser;
                          return AlertDialog(
                            title: const Text('Data berhasil di tambah'),
                            content: const Text('ok'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                  setState(() {});
                });
              },
            ),
          ],
        ),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
