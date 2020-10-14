// importing google platform packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

// include own Flutter code files
import 'package:japaneseapp/tts.dart';

class GetVariant extends StatelessWidget {
  GetVariant(this.context, this.documentSnapshot, this.index);
  final BuildContext context;
  final DocumentSnapshot documentSnapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: new Text(
          'Usage Samples',
          style: GoogleFonts.tangerine(
            fontSize: 36,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _getVariants(context, documentSnapshot, index),
    );
  }
}

Widget _getVariants(
    BuildContext context, DocumentSnapshot documentSnapshot, int index) {
  int _myNo = documentSnapshot.get('No');
  return Scaffold(
    backgroundColor: Colors.blue[200],
    body: Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('myWordVariations')
            .orderBy('SequenceNo', descending: false)
            .where('No', isEqualTo: _myNo)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading ...',
                  style: GoogleFonts.tangerine(
                      fontSize: 24, fontWeight: FontWeight.w400)),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) =>
                  _buildVariants(context, snapshot.data.docs[index], index),
            );
          }
        },
      ),
    ),
  );
}

Widget _buildVariants(
    BuildContext context, DocumentSnapshot documentSnapshot, int index) {
  return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              documentSnapshot.get('Kanji'),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
          ),
          ListTile(
            visualDensity: VisualDensity.comfortable,
            dense: true,
            isThreeLine: false,
            leading: Text(documentSnapshot.get('No').toString() +
                '.' +
                documentSnapshot.get('SequenceNo').toString()),
            title: Text(
              documentSnapshot.get('Kana'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(documentSnapshot.get('English'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            trailing: IconButton(
              icon: Icon(Icons.volume_up),
              color: Colors.blue,
              onPressed: () => {
                speakText(documentSnapshot.get('Kana'), 'ja-JP'),
              },
            ),
          ),
        ],
      ),
    ),
  ]));
}
