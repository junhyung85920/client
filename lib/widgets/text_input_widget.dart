import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/theme.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller,
      required this.onTextChanged});

  final String title;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: CupertinoTextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              placeholder: hintText,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                print(value);
                onTextChanged();
              },
              onTap: () {},
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
