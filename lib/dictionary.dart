// importing google platform packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flip_card/flip_card.dart';

//importing own library
import 'package:japaneseapp/drawer.dart';
import 'package:japaneseapp/tts.dart';
import 'package:japaneseapp/global.dart' as global;

class Dictionary extends StatefulWidget {
  Dictionary();
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "ステファンの日本語",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: (global.myFiltered)
                ? Icon(Icons.filter_list)
                : Icon(Icons.filter_none),
            iconSize: 30.0,
            color: Colors.yellow,
            onPressed: () => {
              setState(() => (global.myFiltered)
                  ? global.myFiltered = false
                  : global.myFiltered = true),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dictionary(),
                ),
              ),
            },
          )
        ],
      ),
      drawer: showMenuDrawer(context),
      body: Container(
        child: StreamBuilder(
          stream: (global.myFiltered)
              ? FirebaseFirestore.instance
                  .collection('myVocabulary')
                  .orderBy('No', descending: false)
                  .where('Favorite', isEqualTo: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('myVocabulary')
                  .orderBy('No', descending: false)
                  .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Loading ...',
                  style: GoogleFonts.tangerine(
                    fontSize: 24,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) =>
                  _buildList(context, snapshot.data.docs[index], index),
            );
          },
        ),
        color: Colors.blue[200],
        padding: EdgeInsets.all(10.10),
      ),
    );
  }
}

Widget _buildList(
    BuildContext context, DocumentSnapshot documentSnapshot, int index) {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  void updateDictionaryFavorite() {
    if (documentSnapshot.get('Favorite')) {
      FirebaseFirestore.instance
          .collection('myVocabulary')
          .doc(documentSnapshot.id)
          .update({'Favorite': false}).catchError(
        (error) => print('updateDictionaryFavorite: Firestore error'),
      );
    } else {
      FirebaseFirestore.instance
          .collection('myVocabulary')
          .doc(documentSnapshot.id)
          .update({'Favorite': true}).catchError(
        (error) => print('updateDictionaryFavorite: Firestore error'),
      );
    }
  }

  return Center(
    child: FlipCard(
      key: cardKey,
      flipOnTouch: false,
      direction: FlipDirection.HORIZONTAL,
      front: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity.comfortable,
              dense: true,
              isThreeLine: false,
              focusColor: Colors.blue,
              hoverColor: Colors.blueAccent,
              leading: Text(documentSnapshot.get('No').toString()),
              title: Text(
                documentSnapshot.get('Japanese'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                documentSnapshot.get('Kana'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Wrap(
                spacing: 0,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.volume_up),
                    color: Colors.blue,
                    onPressed: () => {
                      speakText(documentSnapshot.get('Kana'), 'ja-JP'),
                    },
                  ),
                  IconButton(
                    icon: (documentSnapshot.get('Favorite'))
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    color: Colors.red[400],
                    iconSize: 24.0,
                    onPressed: () => {
                      updateDictionaryFavorite(),
                    },
                  ),
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.all(5.0),
              children: [
                FlatButton(
                  textColor: Colors.blue,
                  child: const Text('toggle for English',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    cardKey.currentState.toggleCard();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      back: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity.comfortable,
              dense: true,
              isThreeLine: false,
              focusColor: Colors.blue,
              hoverColor: Colors.blueAccent,
              leading: Text(documentSnapshot.get('No').toString()),
              title: Text(
                documentSnapshot.get('English'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                color: Colors.blue,
                onPressed: () => {
                  speakText(documentSnapshot.get('English'), 'en-US'),
                },
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.all(5.0),
              children: [
                FlatButton(
                  textColor: Colors.blue,
                  child: const Text('toggle for Japanese',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    cardKey.currentState.toggleCard();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
