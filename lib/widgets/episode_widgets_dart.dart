import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webToonId,
  });

  final String webToonId;
  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    // 방법 2 : final url = Uri.parse("https://google.com");
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webToonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.blue.shade200,
          ),
          borderRadius: BorderRadius.circular(18),
          color: Colors.blue.shade800,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(1, 10),
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
