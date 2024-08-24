import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Moderator {
  final int id;
  final String vorname;
  final String name;
  final String spitzname;
  final String show;
  final String picture;
  bool isVotedUp;
  bool isVotedDown;

  Moderator({
    required this.id,
    required this.vorname,
    required this.name,
    required this.spitzname,
    required this.show,
    required this.picture,
    this.isVotedUp = false,
    this.isVotedDown = false,
  });

  factory Moderator.fromJson(Map<String, dynamic> json) {
    return Moderator(
      id: json['id'],
      vorname: json['vorname'],
      name: json['name'],
      spitzname: json['spitzname'],
      show: json['show'],
      picture: json['picture'],
    );
  }
}

class ApiService {
  Future<List<Moderator>> fetchModerators() async {
    // random delay to simulate network latency
    final randomDelay = Random().nextInt(800);
    await Future.delayed(Duration(milliseconds: randomDelay));
    final String response =
        await rootBundle.loadString('lib/assets/moderators.json');
    List<dynamic> data = json.decode(response);
    return data.map((json) => Moderator.fromJson(json)).toList();
  }

  Future<void> sendFeedback(int id, String voteType) async {
    final Uri url = Uri.parse('https://mod-dashboard.com/feedback/moderator');
    final Map<String, dynamic> feedback = {
      'id': id,
      'voteType': voteType,
    };
    await http
        .post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(feedback),
    )
        .then((response) {
      // handle responses here (not doing it because it's only a demo)
    }).catchError((error) {
      // handle errors here (not doing it because it's only a demo)
    });
  }
}

class ModeratorsPage extends StatefulWidget {
  const ModeratorsPage({super.key});

  @override
  ModeratorsPageState createState() => ModeratorsPageState();
}

class ModeratorsPageState extends State<ModeratorsPage> {
  final ApiService apiService = ApiService();
  late Future<List<Moderator>> _moderatorsFuture;
  List<Moderator>? _moderators;

  void showSnackbar(String message) {
    // closing all previous snackbars
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _moderatorsFuture = apiService.fetchModerators().then((moderators) {
      setState(() {
        _moderators = moderators;
      });
      return moderators;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Moderator>>(
      future: _moderatorsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return ListView.builder(
            itemCount: _moderators?.length ?? 0,
            itemBuilder: (context, index) {
              Moderator moderator = _moderators![index];
              bool isVoted = moderator.isVotedUp || moderator.isVotedDown;
              return ListTile(
                title: Text(
                    '${moderator.vorname} "${moderator.spitzname}" ${moderator.name}'),
                subtitle: Text('Show: ${moderator.show}'),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(moderator.picture),
                  backgroundColor: Colors.yellow,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: isVoted
                            ? (moderator.isVotedUp ? Colors.blue : Colors.grey)
                            : Colors.black,
                      ),
                      onPressed: isVoted
                          ? null
                          : () {
                              setState(() {
                                moderator.isVotedUp = true;
                              });
                              apiService.sendFeedback(moderator.id, 'up');
                              showSnackbar('Danke für dein Feedback!');
                            },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.thumb_down,
                        color: isVoted
                            ? (moderator.isVotedDown
                                ? Colors.blue
                                : Colors.grey)
                            : Colors.black,
                      ),
                      onPressed: isVoted
                          ? null
                          : () {
                              setState(() {
                                moderator.isVotedDown = true;
                              });
                              apiService.sendFeedback(moderator.id, 'down');
                              showSnackbar('Danke für dein Feedback!');
                            },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
