import 'package:flutter/material.dart';
import 'package:pop_up_the_local/style/theme.dart';

class RecommendedStoreInfoWidget extends StatelessWidget {
  final String location;
  final String title;
  final String imagePath;
  final String comment;

  const RecommendedStoreInfoWidget({
    super.key,
    required this.location,
    required this.title,
    required this.imagePath,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text("$location $title",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Container(
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
              height: 38,
              width: 118,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: ColorTheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '상세 보기',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(imagePath) // 프로필 이미지 URL
                  ),
            ),
            Container(
              width: 280,
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                comment,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
