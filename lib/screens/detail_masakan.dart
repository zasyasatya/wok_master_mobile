import 'package:flutter/material.dart';

class MasakanDetail extends StatelessWidget {
  // const MasakanDetail({super.key});

  final Map masakan;

  MasakanDetail({required this.masakan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Masakan"),
      ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(masakan['nama'], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))
            ),
             Container(
              padding: EdgeInsets.all(20),
                  child: Text("Harga : " + masakan['harga'].toString(), style: TextStyle(fontSize: 20.0))
            ),
             Container(
              padding: EdgeInsets.all(5),
                  child: Text("Deskripsi : " + masakan['deskripsi'], style: TextStyle(fontSize: 20.0))
            ),
            // Container(
            // padding: EdgeInsets.all(20),
            // child: Text("Harga : ", style: TextStyle(fontSize: 20.0)))
            
          ],
        )
    );
    // Container(
    //   child: Text(masakan['nama'])
    // );
  }
}