import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_clone/screens/video_player_screen.dart';
import 'package:youtube_clone/screens/video_search.dart';
import 'dart:convert';
import '../modal/modals.dart';


const String API_KEY = 'AIzaSyDUj1q4U1E2AxCReqYgyTgB05eyDOilz94';
const String CHANNEL_ID = 'UC_x5XG1OV2P6uZZ5FSM9Ttw';
const String BASE_URL = 'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=20&channelId=$CHANNEL_ID&key=$API_KEY';

class YouTubeHome extends StatefulWidget {
  @override
  YouTubeHomeState createState() => YouTubeHomeState();
}

class YouTubeHomeState extends State<YouTubeHome> {
  List<VideoModel> videos = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos([String query = '']) async {
    final url = query.isEmpty
        ? BASE_URL
        : 'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=20&q=$query&key=$API_KEY';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        videos = (data['items'] as List).map((json) => VideoModel.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(
            children: [
              Image.asset(
                'assets/youtube logo.png',
                height: 30,
              ),
              SizedBox(width: 8),
              Text(
                'YouTube Clone',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  showSearch(context: context, delegate: VideoSearch(fetchVideos));
                },
              ),
              SizedBox(width: 16),
              Icon(Icons.cast, color: Colors.black),
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Baking'),
              Tab(text: 'DIY Projects'),
            ],
          ),
        ),
        body: videos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(videoId: video.videoId),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(video.thumbnail),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            video.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}