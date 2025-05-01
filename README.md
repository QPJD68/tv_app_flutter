import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(TelevisionApp());
}

class TelevisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ابن عيال🤡 - قنوات التلفزيون',
      theme: ThemeData.dark(),
      home: ChannelListPage(),
    );
  }
}

class ChannelListPage extends StatefulWidget {
  @override
  _ChannelListPageState createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  final List<Map<String, String>> channels = [
    {
      'name': 'قناة تجريبية',
      'url': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
      'frequency': '12345 H 27500'
    },
  ];

  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final frequencyController = TextEditingController();

  void addChannel() {
    if (nameController.text.isNotEmpty && urlController.text.isNotEmpty) {
      setState(() {
        channels.add({
          'name': nameController.text,
          'url': urlController.text,
          'frequency': frequencyController.text
        });
      });
      nameController.clear();
      urlController.clear();
      frequencyController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ابن عيال🤡 - القنوات')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'اسم القناة'),
                ),
                TextField(
                  controller: urlController,
                  decoration: InputDecoration(labelText: 'رابط البث'),
                ),
                TextField(
                  controller: frequencyController,
                  decoration: InputDecoration(labelText: 'تردد القناة'),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: addChannel, child: Text('إضافة قناة')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: channels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(channels[index]['name'] ?? ''),
                  subtitle: Text('تردد: ${channels[index]['frequency']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(
                          channelName: channels[index]['name']!,
                          videoUrl: channels[index]['url']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class PlayerScreen extends StatefulWidget {
  final String channelName;
  final String videoUrl;

  PlayerScreen({required this.channelName, required this.videoUrl});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<Player
ابن عيال
