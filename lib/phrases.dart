import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flip_card/flip_card.dart';

//importing own library
import 'package:japaneseapp/drawer.dart';
import 'package:japaneseapp/tts.dart';
import 'package:japaneseapp/global.dart' as global;

class Phrases extends StatefulWidget {
  Phrases();
  @override
  _PhrasesState createState() => _PhrasesState();
}

class _PhrasesState extends State<Phrases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "ステファンの日本語",
          style: GoogleFonts.tangerine(
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
                  builder: (context) => Phrases(),
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
                  .collection('myPhrases')
                  .orderBy('No', descending: false)
                  .where('Favorite', isEqualTo: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('myPhrases')
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
  void updatePhrasesFavorite() {
    if (documentSnapshot.get('Favorite')) {
      FirebaseFirestore.instance
          .collection('myPhrases')
          .doc(documentSnapshot.id)
          .update({'Favorite': false}).catchError(
        (error) => print('Phrases: Firestore error accessing Phrases'),
      );
    } else {
      FirebaseFirestore.instance
          .collection('myPhrases')
          .doc(documentSnapshot.id)
          .update({'Favorite': true}).catchError(
        (error) => print('Phrases: Firestore error accessing Phrases'),
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
                documentSnapshot.get('WordJapanese'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
                maxLines: 1,
              ),
              subtitle: Text(
                documentSnapshot.get('Japanese'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                softWrap: true,
                maxLines: 7,
              ),
              trailing: Wrap(
                spacing: 0,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.volume_up),
                    color: Colors.blue,
                    onPressed: () => {
                      speakText(documentSnapshot.get('Japanese'), 'ja-JP'),
                    },
                  ),
                  IconButton(
                    icon: (documentSnapshot.get('Favorite'))
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    color: Colors.red[400],
                    iconSize: 24.0,
                    onPressed: () => {
                      updatePhrasesFavorite(),
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
                documentSnapshot.get('WordEnglish'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
                maxLines: 1,
              ),
              subtitle: Text(
                documentSnapshot.get('English'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                softWrap: true,
                maxLines: 7,
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
