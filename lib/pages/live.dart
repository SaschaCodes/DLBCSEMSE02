import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final List<bool> _isPressed = [false, false];
  bool isVoted = false;
  late Future<Map<String, dynamic>> currentSong;
  Map<String, dynamic>? songData;

  @override
  void initState() {
    super.initState();
    currentSong = getCurrentSong();
  }

  Future<Map<String, dynamic>> getCurrentSong() async {
    late List<dynamic> jsonData;

    final Map<String, Object> response = {
      "statusCode": 200,
      "body": json.encode([
        {
          "song": "Mr. Brightside",
          "artist": "The Killers",
          "album": "Hot Fuss"
        },
        {"song": "Take Me to Church", "artist": "Hozier", "album": "Hozier"},
        {
          "song": "Blinding Lights",
          "artist": "The Weeknd",
          "album": "After Hours"
        },
        {
          "song": "Watermelon Sugar",
          "artist": "Harry Styles",
          "album": "Fine Line"
        },
        {
          "song": "Levitating",
          "artist": "Dua Lipa",
          "album": "Future Nostalgia"
        },
        {"song": "Good 4 U", "artist": "Olivia Rodrigo", "album": "SOUR"},
        {"song": "Peaches", "artist": "Justin Bieber", "album": "Justice"},
        {
          "song": "Save Your Tears",
          "artist": "The Weeknd",
          "album": "After Hours"
        },
        {"song": "Kiss Me More", "artist": "Doja Cat", "album": "Planet Her"},
        {
          "song": "Montero (Call Me By Your Name)",
          "artist": "Lil Nas X",
          "album": "Montero"
        },
        {"song": "Stay", "artist": "The Kid LAROI", "album": "F*ck Love"},
        {
          "song": "Drivers License",
          "artist": "Olivia Rodrigo",
          "album": "SOUR"
        },
        {"song": "Deja Vu", "artist": "Olivia Rodrigo", "album": "SOUR"},
        {"song": "Industry Baby", "artist": "Lil Nas X", "album": "Montero"},
        {"song": "Butter", "artist": "BTS", "album": "Butter"},
        {"song": "Bad Habits", "artist": "Ed Sheeran", "album": "="},
        {"song": "Shivers", "artist": "Ed Sheeran", "album": "="},
        {"song": "Heat Waves", "artist": "Glass Animals", "album": "Dreamland"},
        {"song": "Permission to Dance", "artist": "BTS", "album": "Butter"},
        {
          "song": "My Universe",
          "artist": "Coldplay",
          "album": "Music of the Spheres"
        },
        {"song": "Easy on Me", "artist": "Adele", "album": "30"},
        {
          "song": "Happier Than Ever",
          "artist": "Billie Eilish",
          "album": "Happier Than Ever"
        },
        {"song": "Need to Know", "artist": "Doja Cat", "album": "Planet Her"},
        {
          "song": "Smokin Out The Window",
          "artist": "Bruno Mars, Anderson .Paak, Silk Sonic",
          "album": "An Evening with Silk Sonic"
        },
        {"song": "Woman", "artist": "Doja Cat", "album": "Planet Her"},
        {
          "song": "Fancy Like",
          "artist": "Walker Hayes",
          "album": "Country Stuff"
        },
        {"song": "Ghost", "artist": "Justin Bieber", "album": "Justice"},
        {
          "song": "Cold Heart",
          "artist": "Elton John, Dua Lipa",
          "album": "The Lockdown Sessions"
        },
        {
          "song": "One Right Now",
          "artist": "Post Malone, The Weeknd",
          "album": "One Right Now"
        },
        {
          "song": "Love Nwantiti (Ah Ah Ah)",
          "artist": "CKay",
          "album": "CKay the First"
        },
        {
          "song": "Meet Me At Our Spot",
          "artist": "THE ANXIETY, WILLOW, Tyler Cole",
          "album": "THE ANXIETY"
        },
        {
          "song": "You Right",
          "artist": "Doja Cat, The Weeknd",
          "album": "Planet Her"
        },
        {
          "song": "Moth to a Flame",
          "artist": "Swedish House Mafia, The Weeknd",
          "album": "Paradise Again"
        },
        {
          "song": "Enemy",
          "artist": "Imagine Dragons, JID",
          "album": "Arcane League of Legends"
        },
        {"song": "abcdefu", "artist": "GAYLE", "album": "abcdefu"},
        {
          "song": "That's What I Want",
          "artist": "Lil Nas X",
          "album": "Montero"
        },
        {
          "song": "Don't Go Yet",
          "artist": "Camila Cabello",
          "album": "Familia"
        },
        {"song": "I AM WOMAN", "artist": "Emmy Meli", "album": "I AM WOMAN"},
        {"song": "Wild Side", "artist": "Normani", "album": "Wild Side"},
        {
          "song": "Sweater Weather",
          "artist": "The Neighbourhood",
          "album": "I Love You."
        },
        {"song": "traitor", "artist": "Olivia Rodrigo", "album": "SOUR"},
        {
          "song": "Sad Girlz Luv Money",
          "artist": "Amaarae, Moliy",
          "album": "The Angel You Don't Know"
        },
        {
          "song": "Paris",
          "artist": "Ingrid Michaelson",
          "album": "Songs for the Season"
        },
        {
          "song": "No Friends in the Industry",
          "artist": "Drake",
          "album": "Certified Lover Boy"
        },
        {"song": "Rapstar", "artist": "Polo G", "album": "Hall of Fame"},
        {
          "song": "Leave the Door Open",
          "artist": "Bruno Mars, Anderson .Paak, Silk Sonic",
          "album": "An Evening with Silk Sonic"
        },
        {"song": "traitor", "artist": "Olivia Rodrigo", "album": "SOUR"},
        {"song": "Big Energy", "artist": "Latto", "album": "Big Energy"},
        {
          "song": "Love Again",
          "artist": "Dua Lipa",
          "album": "Future Nostalgia"
        },
        {
          "song": "Cold Heart (PNAU Remix)",
          "artist": "Elton John, Dua Lipa",
          "album": "The Lockdown Sessions"
        }
      ]),
    };

    // random delay to simulate network latency
    final randomDelay = Random().nextInt(800);
    await Future.delayed(Duration(milliseconds: randomDelay));

    if (response['statusCode'] == 200) {
      // Parse the JSON data
      jsonData = json.decode(response['body'] as String);

      // random number between 0 and jsonData.length
      final randomIndex = Random().nextInt(jsonData.length);

      return jsonData[randomIndex];
    } else {
      throw Exception('Failed to load song');
    }
  }

  void _sendFeedback(String feedback, String song) {
    final url = Uri.parse('https://mod-dashboard.com/feedback/song');
    http
        .post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'feedback': feedback, 'song': song}),
    )
        .then((response) {
      if (response.statusCode != 200) {}
    }).catchError((error) {});
  }

  void _thumbsUp(Map<String, dynamic> songData) {
    _sendFeedback('up', songData['song']);
    setState(() {
      isVoted = true;
      _isPressed[1] = false;
      _isPressed[0] = !_isPressed[0];
    });
  }

  void _thumbsDown(Map<String, dynamic> songData) {
    _sendFeedback('down', songData['song']);
    setState(() {
      isVoted = true;
      _isPressed[0] = false;
      _isPressed[1] = !_isPressed[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: currentSong,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final songData = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.music_note_rounded,
                size: 65,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      songData['song'] ?? "Song",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      songData['artist'] ?? "Artist",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      songData['album'] ?? "Album",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up_rounded,
                      color: isVoted & !_isPressed[0]
                          ? Colors.grey
                          : _isPressed[0]
                              ? Colors.blue
                              : Colors.black,
                    ),
                    onPressed: isVoted ? null : () => _thumbsUp(songData),
                    iconSize: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.thumb_down_rounded,
                      color: isVoted & !_isPressed[1]
                          ? Colors.grey
                          : _isPressed[1]
                              ? Colors.blue
                              : Colors.black,
                    ),
                    onPressed: isVoted ? null : () => _thumbsDown(songData),
                    iconSize: 40,
                  ),
                ],
              )
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
