import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/UserController.dart';
import 'package:flutter_application_1/views/customtextField.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController feeController = TextEditingController();
  final UserController userController = Get.find<UserController>();
  bool buy = false;

  Future<void> _submitTransaction() async {
    final Uri apiUrl = Uri.parse('http://127.0.0.1:8000/user/transactions/');

    try {
      print(userController.user!.toJson());
      final http.Response response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "user": userController.user!.id,
            "name": nameController.text.trim(),
            "time": timeController.text.trim(),
            "fee": feeController.text.trim(),
            "buy": buy
          },
        ),
      );

      print(response.body);
      if (response.statusCode == 201) {
        // Transaction added successfully
        Get.snackbar("Success", "Successfully saved!");
      } else {
        // Failed to add transaction
        Get.snackbar("Error", "Error: ${response.body}");
      }
    } catch (e) {
      // Error connecting to the server
      Get.snackbar("Error", "Failed to connect to the server");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          Controller: nameController,
          decoration: InputDecoration(labelText: 'Name of the transaction'),
        ),
        CustomTextField(
          Controller: timeController,
          decoration: InputDecoration(labelText: 'Time'),
        ),
        CustomTextField(
          Controller: feeController,
          decoration: InputDecoration(labelText: 'Amount'),
        ),
        Row(
          children: [
            Checkbox(
              value: buy,
              onChanged: (value) {
                setState(() {
                  buy = value!;
                });
              },
            ),
            Text('Expense'),
          ],
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await _submitTransaction();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}

class TransactionFormDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
      child: TransactionForm(),
      ),
    );
  }
}
