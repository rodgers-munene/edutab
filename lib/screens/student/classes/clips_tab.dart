import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ClipsTab extends StatefulWidget {
  const ClipsTab({super.key});

  @override
  State<ClipsTab> createState() => _ClipsTabState();
}

class _ClipsTabState extends State<ClipsTab> {
  final List<Map<String, String>> videos = [
    {
      "id": "K4TOrB7at0Y",
      "title": "Flutter Tutorial for Beginners",
      "channel": "freeCodeCamp.org",
      "thumbnail": "https://img.youtube.com/vi/K4TOrB7at0Y/0.jpg",
    },
    {
      "id": "1gDhl4leEzA",
      "title": "Data Structures Full Course",
      "channel": "Bro Code",
      "thumbnail": "https://img.youtube.com/vi/1gDhl4leEzA/0.jpg",
    },
  ];

  String? selectedVideoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video List
          ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedVideoId = video["id"];
                  });
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          video["thumbnail"]!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video["title"]!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              video["channel"]!,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Centered Floating YouTube Player
          if (selectedVideoId != null) _buildCenteredPlayer(),
        ],
      ),
    );
  }

  Widget _buildCenteredPlayer() {
    final embedUrl =
        "https://www.youtube.com/embed/$selectedVideoId?autoplay=1&playsinline=1";

    return Stack(
      children: [
        // Dimmed background
        GestureDetector(
          onTap: () => setState(() => selectedVideoId = null),
          child: Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // Centered YouTube Player
        Center(
          child: Material(
            elevation: 12,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Stack(
                children: [
                  WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(Uri.parse(embedUrl)),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => setState(() => selectedVideoId = null),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
