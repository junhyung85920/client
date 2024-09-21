import 'package:flutter/material.dart';

class SignUpCustomerScreen extends StatefulWidget {
  const SignUpCustomerScreen({super.key});

  @override
  State<SignUpCustomerScreen> createState() => _SignUpCustomerScreenState();
}

class _SignUpCustomerScreenState extends State<SignUpCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("이름 (닉네임)"),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "이름을 입력하세요",
                hintText: "여기에 이름을 입력하세요",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitName,
              child: Text("제출"),
            ),
          ],
        ),
      ),
    );
  }

  void _submitName() {
    // 이름 제출 로직
    String name = _nameController.text;
    if (name.isEmpty) {
      // 입력 필드가 비어있는 경우, 사용자에게 경고
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("경고"),
          content: Text("이름을 입력해야 합니다."),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      // 입력된 이름 처리 (예: 서버로 전송, 로컬 데이터베이스에 저장 등)
      print("입력된 이름: $name");
    }
  }
}
