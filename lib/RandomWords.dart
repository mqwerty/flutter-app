import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _suggestions = generateWordPairs().take(5).toList();
  final _saved = <WordPair>{};

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map((WordPair pair) => ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              ));
          final body = tiles.length == 0
              ? Center(child: Text('Nothing saved yet...', style: _biggerFont))
              : ListView(
                  children: ListTile.divideTiles(context: context, tiles: tiles)
                      .toList());
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: body,
          );
        },
      ),
    );
  }

  void _add() {
    setState(() {
      _suggestions.addAll(generateWordPairs().take(5));
    });
  }

  Widget _buildSuggestions() {
    return ListView.separated(
      padding: EdgeInsets.all(16.0),
      itemCount: _suggestions.length + 1,
      itemBuilder: (context, i) =>
          i == _suggestions.length ? _buildBtn() : _buildRow(_suggestions[i]),
      separatorBuilder: (context, i) => Divider(),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
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
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  Widget _buildBtn() {
    return ListTile(
      title: Text(
        '+',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32.0, color: Colors.white),
      ),
      tileColor: Colors.purple,
      onTap: _add,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
