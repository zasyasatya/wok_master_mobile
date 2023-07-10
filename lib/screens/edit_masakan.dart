import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wok_master/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditMasakan extends StatelessWidget {

  final Map masakan;

  EditMasakan({required this.masakan});

  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  Future updateMasakan() async {
    final response = await http.post(Uri.parse("http://192.168.43.221:8000/masakan/update/" + masakan['id'].toString()), body: {
      "nama": _namaController.text,
      "harga": _hargaController.text,
      "deskripsi": _deskripsiController.text,
    });

    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Masakan")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _namaController..text = masakan['nama'],
              decoration: InputDecoration(labelText: "Nama Masakan"),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return "Isi Nama Masakan";
                }
                return null;
              }
            ),
            TextFormField(
              controller: _hargaController..text = masakan['harga'].toString(),
              decoration: InputDecoration(labelText: "Harga"),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return "Isi Harga Masakan";
                }
                return null;
              }
            ),
            TextFormField(
              controller: _deskripsiController..text = masakan['deskripsi'],
              decoration: InputDecoration(labelText: "Deskripsi"),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return "Isi Deskripsi Masakan";
                }
                return null;
              }
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                    updateMasakan().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Masakan berhasil di-update")));
                });
                }
              }, child: Text("Create")
            )
          ],
        ),)
    );
  }
}