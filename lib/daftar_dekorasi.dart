import 'package:aplikasi_jual_dekor/edit_dekorasi.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi_jual_dekor/koneksi.dart';
import 'package:aplikasi_jual_dekor/daftar_dekorasi.dart';

class DataDekorasi extends StatefulWidget {
  DataDekorasi();

  @override
  _DataDekorasiState createState() => _DataDekorasiState();
}

class _DataDekorasiState extends State<DataDekorasi> {

  bool loading = false;
  List<DocumentSnapshot> DataDekor = List();

  DataDekors()async{
    setState(() {
      loading  = true;
    });
    DataDekor = await Koneksi.koneksi.GetDekor();
    setState(() {
      loading = false;
    });
  }

  HapusData(String idDocument){
    setState(() {
      loading  = true;
    });

    Koneksi.koneksi.HapusDekorasi(idDocument).then((_){
      DataDekors();
//      Navigator.pop(context);
    });
  }

  @override
  void initState(){
    super.initState();
    DataDekors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text('Data Dekorasi',style: TextStyle(
          color: Colors.white,
        )),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
//              width: 200,
          height: 700,
          width: MediaQuery.of(context).size.width,
//          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SizedBox(
//                      height: 250.0,
                  child: loading ? Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent[400]),
                  ),) :
                  ListView.builder(
                    itemCount: DataDekor.length,
                    itemBuilder: (context, i){
                      final number = i+1;
                      final item = DataDekor[i];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
//                                color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                             Icon(
                                               Icons.graphic_eq,
                                               color: Colors.white,
                                             ),
                                              Text(item.data['ukuran'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.attach_money,
                                                color: Colors.white,
                                              ),
                                              Text(item.data['harga'], style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,

                                              ),),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.library_books,
                                                color: Colors.white,
                                              ),
                                              Text(' '+item.data['keterangan'], style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,

                                              ),),
                                            ],
                                          ),
//                                          Row(
//                                            children: <Widget>[
//
//                                              Container(width: 4,),
//                                              Text(item.data['nomor_rak'], style: TextStyle(
//                                                fontSize: 18,
//                                                color: Colors.white,
//
//                                              ),),
//                                            ],
//                                          ),
                                        ],
                                      ),
                                    ),

                                  ),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  borderRadius: new BorderRadius.only(
                                      bottomRight:  const  Radius.circular(14),
                                      topRight: const  Radius.circular(14))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => EditDekorasi(
                                                    reloadData:DataDekors,
                                                    idDocument: item.documentID,
                                                    ukuran: item.data['ukuran'],
                                                    harga: item.data['harga'],
                                                    keterangan: item.data['keterangan'],
                                                  )
                                              )
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Text('Edit ', style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.teal,
                                              ),),
                                            ),
//                                  Container(width: 2),
                                            Container(
//                                    margin: new EdgeInsets.all(1),
                                              padding: new EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.teal,
                                                ),
                                                borderRadius: BorderRadius.circular(40.0),
                                              ),
                                              child: new Icon(
                                                Icons.edit,
                                                color: Colors.teal,
                                                size: 24.0,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: (){
                                          HapusData(item.documentID);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Text('Hapus ', style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red
                                              ),),
                                            ),
                                            Container(
//                                    margin: new EdgeInsets.all(1),
                                              padding: new EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.red,
                                                ),
                                                borderRadius: BorderRadius.circular(40.0),
                                              ),
                                              child: new Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 24.0,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}