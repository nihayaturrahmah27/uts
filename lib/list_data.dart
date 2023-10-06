import 'dart:async';
import 'dart:convert';

import 'package:uts/edit_data.dart';
import 'package:uts/read_data.dart';
import 'package:uts/side_menu.dart';
import 'package:uts/tambah_data.dart';
import 'package:flutter/material.dart';
// import 'package:read_edit/side_menu.dart';
// import 'package:read_edit/tambah_data.dart';
import 'package:http/http.dart' as http;
//import 'package:universal_platform/universal_platform.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataKontak = [];
  // String url = Platform.isAndroid
  //     ? 'http://10.101.3.95/tugaspemmob/index.php'
  //     : 'http://localhost/api_flutter/index.php';
  String url = 'http://10.98.5.74/uts/index.php';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        dataKontak = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'kontak': item['kontak'] as String,
            'email': item['email'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int id) async {
    final response = await http.delete(Uri.parse('$url?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Kontak'),
      ),
      drawer: const SideMenu(),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahData(),
              ),
            );
          },
          child: const Text('Tambah Data Kontak'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataKontak.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataKontak[index]['nama']!),
                subtitle: Text('kontak: ${dataKontak[index]['kontak']}',
                    semanticsLabel: 'email: ${dataKontak[index]['email']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReadData(
                                id: dataKontak[index]['id'].toString(),
                                nama: dataKontak[index]['nama'] as String,
                                kontak: dataKontak[index]['kontak'] as String,
                                email: dataKontak[index]['email'] as String),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditData(
                                id: dataKontak[index]['id'].toString(),
                                nama: dataKontak[index]['nama'] as String,
                                kontak: dataKontak[index]['kontak'] as String,
                                email: dataKontak[index]['email'] as String),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteData(int.parse(dataKontak[index]['id']!))
                            .then((result) {
                          if (result['pesan'] == 'berhasil') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Data berhasil di hapus'),
                                    content: const Text('ok'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListData(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
