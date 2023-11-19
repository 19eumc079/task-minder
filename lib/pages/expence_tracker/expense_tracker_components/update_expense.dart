import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:task_minder/models/expense_tracker_model.dart';
import 'package:task_minder/services/services.dart';

class UpdateExpense extends StatefulWidget {
  const UpdateExpense({super.key});

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  final List<bool> _selectedETypeList = <bool>[true, false];
  List<String> eTypeList = [
    'Expense',
    'Income',
  ];
  String selectedEType = 'Expense';
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController(
      text: CommonMethod().formatDate(DateTime.now(), 'MMM dd, yyyy'));
  TextEditingController expenseNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final expenseBox = Hive.box('expenseTrackerBox');
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        dateController.text = DateFormat("MMM dd, yyyy").format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: const Icon(Icons.chevron_left)),
        title: const Text('Create Expense'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                UnderlineTextfield(
                  controller: expenseNameController,
                  keyboardType: TextInputType.text,
                  labelText: 'Expense Name',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Enter The Name';
                    }
                    return null;
                  },
                ),
                UnderlineTextfield(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Enter The Amout';
                    }
                    return null;
                  },
                  labelText: 'Amount',
                ),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: const InputDecoration(
                    labelText: 'Selected Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedETypeList.length; i++) {
                        _selectedETypeList[i] = i == index;
                      }
                      int selectedIndex = _selectedETypeList.indexOf(true);
                      selectedEType = eTypeList[selectedIndex];
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.red[200],
                  color: Colors.red[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedETypeList,
                  children:
                      eTypeList.map((String eType) => Text(eType)).toList(),
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        ExpenseDatabase().add(ExpenseTrackerModel(
                            eName: expenseNameController.text,
                            eDate: dateController.text,
                            eAmount: amountController.text,
                            eType: selectedEType.toLowerCase()));

                        Navigator.pop(context, true);
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UnderlineTextfield extends StatelessWidget {
  const UnderlineTextfield(
      {super.key,
      required this.labelText,
      required this.validator,
      required this.keyboardType,
      required this.controller});
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),

        // errorBorder: UnderlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
