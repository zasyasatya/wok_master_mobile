import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wok_master/screens/create_masakan.dart';
import 'package:wok_master/screens/detail_masakan.dart';
import 'package:wok_master/screens/edit_masakan.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'http://192.168.43.221:8000/masakan';

  // var uri = Uri.http('http://192.168.43.221:8000', 'masakan');
  Future getMasakans() async {
    var response = await http.get(Uri.parse(url));
    // var response = await client.get(uri);
    print(response.body);
    return json.decode(response.body);
  }

  Future deleteMasakan(String masakanId) async {
    String url = 'http://192.168.43.221:8000/masakan/delete/' + masakanId;

    var response = await http.delete(Uri.parse(url));

    json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMasakan()));
      }, child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text('Wok Master App'),
      ),
      body: FutureBuilder(
        future: getMasakans(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                return Container(
                  height: 70,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MasakanDetail(masakan: snapshot.data['data'][index],)));
                          },
                          child: Container(     
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Padding(padding: const EdgeInsets.only(left: 5),
                                    child: Text(snapshot.data['data'][index]['nama'], style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(padding: const EdgeInsets.only(left: 5),
                                    child: Text(' ' + 'Rp. ' + snapshot.data['data'][index]['harga'].toString()),
                                  ),
                                ],),
                                Row(children: [
                                  Padding(padding: const EdgeInsets.only(left: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditMasakan(masakan: snapshot.data['data'][index])));
                                      },
                                      child: Icon(Icons.edit)
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.only(left: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        deleteMasakan(snapshot.data['data'][index]['id'].toString()).then((value) {
                                          setState(() {
                                            
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Masakan berhasil di-hapus")));
                                        });
                                      },
                                      child: Icon(Icons.delete_outlined)
                                    ),
                                  ),

                                ],)
                                // Align(alignment: Alignment.centerRight,
                                //   child: Icon(Icons.delete_outlined)
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                );
                // return Text(snapshot.data['data'][index]['nama']);
            });
            // return Text('Data Oke');
          }
          else {
            return Text('Data error');
          }
        },
      )
    );
  }
}
