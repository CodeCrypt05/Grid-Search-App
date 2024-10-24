import 'package:flutter/material.dart';
import 'package:grid_app/screens/grid_input_form_screen.dart';

class GridDisplayScreen extends StatefulWidget {
  const GridDisplayScreen({
    super.key,
    required this.alphabets,
    required this.m,
    required this.n,
  });

  final List<String> alphabets;
  final int m;
  final int n;

  @override
  State<GridDisplayScreen> createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  String searchText = '';
  List<bool> highlighted = [];

  @override
  void initState() {
    super.initState();
    highlighted = List.generate(widget.alphabets.length, (_) => false);
  }

  void searchWord(String word) {
    setState(() {
      highlighted = List.generate(
          widget.alphabets.length * widget.alphabets[0].length,
          (_) => false); // reset highlights
      for (int row = 0; row < widget.alphabets.length; row++) {
        for (int col = 0; col < widget.alphabets[row].length; col++) {
          // Search in east direction
          if (searchInDirection(word, row, col, 0, 1)) {
            highlightWord(word, row, col, 0, 1);
          }
          // Search in south direction
          if (searchInDirection(word, row, col, 1, 0)) {
            highlightWord(word, row, col, 1, 0);
          }
          // Search in south-east direction
          if (searchInDirection(word, row, col, 1, 1)) {
            highlightWord(word, row, col, 1, 1);
          }
        }
      }
    });
  }

  void highlightWord(
      String word, int startRow, int startCol, int rowStep, int colStep) {
    int wordLength = word.length;
    int row = startRow;
    int col = startCol;

    for (int i = 0; i < wordLength; i++) {
      highlighted[row * widget.alphabets[0].length + col] = true;
      row += rowStep;
      col += colStep;
    }
  }

  bool searchInDirection(
      String word, int startRow, int startCol, int rowStep, int colStep) {
    int wordLength = word.length;
    int row = startRow;
    int col = startCol;

    print("here is a data: ${widget.alphabets[row][col]}");

    for (int i = 0; i < wordLength; i++) {
      if (row >= widget.alphabets.length ||
          col >= widget.alphabets[0].length ||
          widget.alphabets[row][col] != word[i]) {
        return false;
      }
      row += rowStep;
      col += colStep;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.n,
              ),
              itemCount: widget.alphabets.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  color: highlighted[index] ? Colors.yellow : Colors.white,
                  child: Center(
                    child: Text(widget.alphabets[index]),
                  ),
                );
              },
            ),
          ),
          TextField(
            decoration:
                const InputDecoration(labelText: 'Enter word to search'),
            onChanged: (value) {
              searchText = value;
              // searchWord(searchText);
            },
          ),
          ElevatedButton(
            onPressed: () {
              searchWord(searchText);
            },
            child: const Text('Search Word'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
