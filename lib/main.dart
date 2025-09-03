import 'package:flutter/material.dart';
import 'quote.dart';

void main() {
  runApp(MaterialApp(
    home: QuoteList(),
  ));
}

// Stateful widget
class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}
// State class
class _QuoteListState extends State<QuoteList> {

  List<Quote> quotes = [
    Quote(author: 'Oscar Wilde', text: 'Be yourself; everyone else is already taken', category: 'Embrace' ),
    Quote(author: 'Oscar Wilde', text: 'I have nothing to declare except my genius', category: 'Confidence'),
    Quote(author: 'Oscar Wilde', text: 'The truth is rarely pure and never simple', category: 'Truth' ),
  ];

  Widget quoteTemplate(Quote quote) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quote.text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '- ${quote.author}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 6),
            Chip(
              label: Text(
                quote.category,
                style: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${quote.likes}', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  color: Colors.redAccent,
                  onPressed: () {
                    setState(() {
                      quote.likes++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Qoutes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: quotes.map((quote) => quoteTemplate(quote)).toList(),
      ),
    );
  }
}

