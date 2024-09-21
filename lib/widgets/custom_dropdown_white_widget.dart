import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../style/theme.dart';

class CustomDropdownWhiteWidget extends StatelessWidget {
  const CustomDropdownWhiteWidget(
      {super.key,
      required this.title,
      required this.categories,
      required this.selectedValue,
      required this.onChanged});

  final String title;
  final List<String> categories;
  final String selectedValue;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    int maxLength = 7;

    for (String category in categories) {
      if (category.length > maxLength) {
        maxLength = category.length;
      }
    }

    return Column(
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
        //const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Row(
                children: [
                  Expanded(
                    child: Text(
                      categories[0],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.background,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              value: selectedValue,
              onChanged: onChanged,
              items: categories
                  .map((String category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorTheme.background,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              buttonStyleData: ButtonStyleData(
                height: 30,
                width: maxLength * 16,
                padding: const EdgeInsets.only(left: 16, right: 8),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(0, 0, 0, 0),
                    ),
                    color: Colors.white),
                elevation: 1,
              ),
              iconStyleData: IconStyleData(
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                ),
                iconSize: 20,
                iconEnabledColor: ColorTheme.background,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 150,
                width: maxLength * 16,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(0, 0, 0, 0),
                    ),
                    color: Colors.white),
                offset: const Offset(0, 0),
                scrollbarTheme: const ScrollbarThemeData(
                  radius: Radius.circular(20),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
