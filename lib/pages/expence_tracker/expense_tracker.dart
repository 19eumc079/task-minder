import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_minder/pages/expence_tracker/expense_tracker_components/expense_tracker_components.dart';

import '../../common_widget/alertDialog.dart';
import '../../models/expense_tracker_model.dart';
import '../../services/services.dart';

class ExpenceTracker extends StatefulWidget {
  const ExpenceTracker({super.key});

  @override
  State<ExpenceTracker> createState() => _ExpenceTrackerState();
}

class _ExpenceTrackerState extends State<ExpenceTracker> {
  // final ScrollController _controller = ScrollController();
  final expenseBox = Hive.box('expenseTrackerBox');
  List<ExpenseTrackerModel> expenseList = [];
  bool isButton = false;

  @override
  void initState() {
    super.initState();
    updateList();
  }

  updateList() {
    List<ExpenseTrackerModel> updatedList = expenseBox.get('expenselist');

    setState(() {
      expenseList = updatedList.reversed.toList();
    });
  }

  // scrollDown() {
  //   Future.delayed(const Duration(milliseconds: 300), () {
  //     if (_controller.hasClients) {
  //       _controller.animateTo(
  //         _controller.position.maxScrollExtent,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.fastOutSlowIn,
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(19, 24, 38, 1),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: const Text(
            'Expense Tracker',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () async {
            final bool isload = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UpdateExpense()));
            if (isload) {
              updateList();
            }
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                // controller: _controller,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: expenseList.length,
                itemBuilder: (BuildContext context, int index) {
                  String currentDate = expenseList[index].eDate;

                  return Column(
                    children: [
                      if (index == 0 ||
                          currentDate != expenseList[index - 1].eDate)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            currentDate !=
                                    CommonMethod()
                                        .formatDate(DateTime.now(), 'MMM d, y')
                                ? currentDate
                                : 'Today',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 169, 167, 167),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: GestureDetector(
                          onTap: () => AlertDialogMethod(
                            context: context,
                            cancel: TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                updateList();
                                Navigator.of(context).pop();
                              },
                            ),
                            ok: TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                ExpenseDatabase()
                                    .delete(expenseList.length - 1 - index);
                                updateList();
                                Navigator.of(context).pop();
                              },
                            ),
                          ).showMyDialog(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(47, 52, 64, 1),
                            ),
                            child: ListTile(
                              leading: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          expenseList[index].eType == 'expense'
                                              ? const Color.fromRGBO(
                                                  255, 208, 153, 1)
                                              : const Color.fromRGBO(
                                                  159, 187, 115, 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      expenseList[index].eType == 'expense'
                                          ? Icons.trending_down
                                          : Icons.trending_up,
                                      color: expenseList[index].eType ==
                                              'expense'
                                          ? const Color.fromRGBO(199, 0, 57, 1)
                                          : const Color.fromRGBO(64, 81, 59, 1),
                                    ),
                                  )),
                              subtitle: Text(
                                expenseList[index].eDate,
                                style: const TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.5)),
                              ),
                              title: SizedBox(
                                width: 250,
                                child: Text(
                                  expenseList[index].eName,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              trailing: Text(
                                expenseList[index].eType != 'expense'
                                    ? '+ ${expenseList[index].eAmount}'
                                    : '- ${expenseList[index].eAmount}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
