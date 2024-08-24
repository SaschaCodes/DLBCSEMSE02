import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> song = {
      'title': '',
      'artist': '',
      'name': '',
    };
    TextEditingController titleController = TextEditingController();
    TextEditingController artistController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    void submitSong() {
      if (titleController.text.isEmpty ||
          artistController.text.isEmpty ||
          nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text(
                'Bitte fülle alle Felder aus!',
                style: TextStyle(color: Colors.black),
              ),
            ),
            backgroundColor: Colors.deepOrange,
          ),
        );
        return;
      }

      final url = Uri.parse('https://mod-dashboard.com/songwish');
      song['title'] = titleController.text;
      song['artist'] = artistController.text;
      song['name'] = nameController.text;
      titleController.clear();
      artistController.clear();
      nameController.clear();
      http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(song),
      )
          .then((response) {
        if (response.statusCode == 200) {
        } else {}
      }).catchError(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Vielen Dank, dein Songwunsch wurde eingereicht!',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              backgroundColor: Colors.lightGreen,
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.headphones, size: 100.0),
            const SizedBox(height: 20.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Songtitel',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: artistController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Interpret',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dein Name',
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
              ),
              onPressed: submitSong,
              child: const Text('Absenden'),
            ),
          ],
        ),
      ),
    );
  }
}
