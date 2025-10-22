import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubeLauncher extends StatelessWidget {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String duration;

  const YouTubeLauncher({
    super.key,
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
  });

  Future<void> _openYouTubeVideo() async {
    final Uri youtubeAppUrl = Uri.parse("vnd.youtube://$videoId");
    final Uri youtubeWebUrl =
        Uri.parse("https://www.youtube.com/watch?v=$videoId");

    // Try to open in YouTube app first
    if (await canLaunchUrl(youtubeAppUrl)) {
      await launchUrl(youtubeAppUrl);
    } else {
      // fallback to browser if YouTube app is not installed
      await launchUrl(youtubeWebUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openYouTubeVideo,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with overlay play icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    thumbnailUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.05)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                // Duration tag
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
