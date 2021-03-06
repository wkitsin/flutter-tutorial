// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: RandomWords(),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: ListView(children: _buildSuggestions()),
    );
  }

  // Widget _buildSuggestions() {
  //   return ListView.builder(
  //       padding: const EdgeInsets.all(16.0),
  //       itemBuilder: /*1*/ (context, i) {
  //         if (i.isOdd) return Divider(); /*2*/

  //         final index = i ~/ 2; /*3*/w
  //         if (index >= _suggestions.length) {
  //           _suggestions.addAll(generateWordPairs().take(10)); /*4*/
  //         }
  //         return _buildRow(_suggestions[index]);
  //       });
  // }

  List<Widget> _buildSuggestions() {
    final Iterable<ListTile> tiles = _suggestions.map(
      (WordPair pair) {
        final bool alreadySaved = _saved.contains(pair);
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(pair);
              } else {
                _saved.add(pair);
              }
            });
          },
        );
      },
    );

    return ListTile.divideTiles(context: context, tiles: tiles).toList();
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ... to here.
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
