import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts/list_data.dart';

class EditData extends StatefulWidget {
  final String id;
  final String nama;
  final String kontak;
  final String email;

  const EditData(
      {Key? key,
      required this.id,
      required this.nama,
      required this.kontak,
      required this.email})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final namaController = TextEditingController();
  final kontakController = TextEditingController();
  final emailController = TextEditingController();

  Future<bool> editData(String id) async {
    String url = 'http://10.98.5.74/uts/index.php';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    String jsonBody =
        '{"id": "${widget.id}", "nama": "${namaController.text}", "kontak": "${kontakController.text}", "email": "${emailController.text}"}';
    var response =
        await http.put(Uri.parse(url), body: jsonBody, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    namaController.value = TextEditingValue(text: widget.nama);
    kontakController.value = TextEditingValue(text: widget.kontak);
    emailController.value = TextEditingValue(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              onPressed: () async {
                await editData(widget.id)
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Success"),
                            content: const Text("Data berhasil di edit."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const ListData()));
                                },
                              ),
                            ],
                          );
                        },
                      )
                    : false;
              },
              child: const Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
