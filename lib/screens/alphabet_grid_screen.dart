import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grid_app/screens/grid_display_screen.dart';

class AlphabetGridScreen extends StatefulWidget {
  const AlphabetGridScreen({
    super.key,
    required this.m,
    required this.n,
  });

  final int m;
  final int n;

  @override
  State<AlphabetGridScreen> createState() => _AlphabetGridScreenState();
}

class _AlphabetGridScreenState extends State<AlphabetGridScreen> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.m * widget.n, (_) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Alphabets')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.n,
                  mainAxisSpacing: 0.0, // Set vertical spacing to zero
                  crossAxisSpacing: 0.0,
                ),
                padding: EdgeInsets.zero,
                itemCount: widget.m * widget.n,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextField(
                      controller: controllers[index],
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      ],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        counterText: '',
                        border: InputBorder.none,
                        // border: OutlineInputBorder(
                        //   borderSide:
                        //       BorderSide(color: Colors.black, width: 1.0),
                        // ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                List<String> alphabets =
                    controllers.map((c) => c.text).toList();

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GridDisplayScreen(
                    alphabets: alphabets,
                    m: widget.m,
                    n: widget.n,
                  ),
                ));
              },
              child: const Text('Create Grid'),
            ),
          ],
        ),
      ),
    );
  }
}
