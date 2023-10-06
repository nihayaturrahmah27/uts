import 'package:flutter/material.dart';

class ReadData extends StatelessWidget {
  final String id;
  final String nama;
  final String kontak;
  final String email;

  const ReadData(
      {Key? key,
      required this.id,
      required this.nama,
      required this.kontak,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lihat Data"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Text(
              'ID: $id',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Nama: $nama',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'kontak: $kontak',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'email: $email',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
