import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, required this.keyWord});

  final String title;
  final String keyWord;

  @override
  Widget build(BuildContext context) {
    List<String> splitTitle = title.split(keyWord);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 114,
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                splitTitle[0].isEmpty
                    ? TextSpan(
                        text: keyWord,
                        style: Theme.of(context).textTheme.headlineMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: splitTitle[1],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      )
                    : TextSpan(
                        text: splitTitle[0],
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: <TextSpan>[
                          TextSpan(
                            text: keyWord,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          TextSpan(
                            text: splitTitle[1],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
