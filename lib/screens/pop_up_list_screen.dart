import 'package:flutter/material.dart';
import 'package:pop_up_the_local/screens/pop_up_detailed_screen.dart';
import 'package:pop_up_the_local/services/pop_up_list_service.dart';
import 'package:pop_up_the_local/widgets/custom_dropdown_widget.dart';

class PopUpListScreen extends StatefulWidget {
  const PopUpListScreen({super.key});

  @override
  State<PopUpListScreen> createState() => _PopUpListScreenState();
}

class _PopUpListScreenState extends State<PopUpListScreen> {
  String _selectedLocation = '전체';
  String _selectedIndustry = '전체';
  List<dynamic> _popupList = [];

  final PopUpListService _popUpListService = PopUpListService();
  final List<String> _industries = <String>[
    '전체',
    '요식',
    '제조',
    '예술',
    '교육',
  ];
  final List<String> _locations = <String>[
    '전체',
    '서울',
    '경기',
    '인천',
    '부산',
    '대구',
    '울산',
    '광주',
    '대전',
    '세종',
    '강원',
    '충북',
    '충남',
    '전북',
    '전남',
    '경북',
    '경남',
    '제주도'
  ];

  @override
  void initState() {
    super.initState();
    _fetchPopUps(_selectedIndustry, _selectedLocation);
  }

  void _fetchPopUps(String industry, String location) async {
    var fetchedPopUps = await _popUpListService.fetchPopUps(industry, location);
    setState(() {
      _popupList = fetchedPopUps;
      _buildPopUpList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('팝업 목록'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomDropdownWidget(
                categories: _industries,
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != _selectedIndustry) {
                    _selectedIndustry = newValue;
                    _fetchPopUps(newValue, _selectedLocation);
                  }
                },
                dropdownValue: _selectedIndustry,
              ),
              CustomDropdownWidget(
                categories: _locations,
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != _selectedLocation) {
                    _selectedLocation = newValue;
                    _fetchPopUps(_selectedIndustry, newValue);
                  }
                },
                dropdownValue: _selectedLocation,
              ),
            ],
          ),
          Expanded(
            child: _buildPopUpList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPopUpList() {
    return ListView.builder(
      itemCount: _popupList.length,
      itemBuilder: (context, index) {
        var popup = _popupList[index];
        return Card(
          elevation: 3,
          shadowColor: Colors.grey[100],
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Text(
              popup.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              popup.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                popup.image,
                width: 90,
                height: 200,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PopUpDetailedScreen(
                    popupId: popup.popup_id,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
