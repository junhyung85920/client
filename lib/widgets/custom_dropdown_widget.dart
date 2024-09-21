import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pop_up_the_local/services/bookmark_service.dart';

import '../style/theme.dart';

class CustomDropdownWidget extends StatelessWidget {
  CustomDropdownWidget(
      {super.key,
      required this.categories,
      required this.dropdownValue,
      required this.onChanged});

  final List<String> categories;
  final Function(String?) onChanged;

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    int maxLength = 7;

    for (String category in categories) {
      if (category.length > maxLength) {
        maxLength = category.length;
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                child: Text(
                  categories[0],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          value: dropdownValue,
          onChanged: onChanged,
          items: categories
              .map((String category) => DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: ColorTheme.background),
            elevation: 1,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down_rounded,
            ),
            iconSize: 20,
            iconEnabledColor: Colors.white,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 150,
            width: maxLength * 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorTheme.background,
            ),
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
    );
  }
}
