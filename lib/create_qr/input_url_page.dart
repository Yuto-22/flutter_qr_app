import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_app/create_qr/create_qr_page.dart';

class InputUrlPage extends StatelessWidget {
  var valueController = TextEditingController();
  InputUrlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Container(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: TextField(
              controller: valueController,
              enabled: true,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 120,
            child: ElevatedButton(
              child: const Text(
                '生成',
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CreateQr(
                            url: valueController.text,
                          )),
                );
                print(valueController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
