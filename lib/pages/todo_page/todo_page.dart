import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../common_widget/common_widget.dart';
import '../../services/services.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController contentController = TextEditingController();
  final ScrollController _controller = ScrollController();
  final todoBox = Hive.box('toDOListBox');
  List<dynamic> todoList = [];
  bool isButton = false;

  @override
  void initState() {
    super.initState();

    updateToDoList();
  }

  Future<void> updateToDoList() async {
    final updatedTodoList = await todoBox.get('toDos') ?? [];
    setState(() {
      todoList = updatedTodoList;
    });
  }

  _scrollDown() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

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
            'Todo List',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: _controller,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  String currentDate = todoList[index]['date'];

                  return Column(
                    children: [
                      if (index == 0 ||
                          currentDate != todoList[index - 1]['date'])
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
                                Navigator.of(context).pop();
                              },
                            ),
                            ok: TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Database().delete(index);
                                updateToDoList();
                                Navigator.of(context).pop();
                              },
                            ),
                          ).showMyDialog(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(47, 52, 64, 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  todoList[index]['content'],
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: todoList[index]
                                                              ['done']
                                                          ? Colors.grey
                                                          : Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                          todoList[index]['done']
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 1,
                                                  color: Colors.grey,
                                                )
                                              : Container(),
                                        ]),
                                  ),
                                  Checkbox(
                                    value: todoList[index]['done'],
                                    onChanged: (value) {
                                      setState(() {
                                        Database().update(index, {
                                          'content': todoList[index]['content'],
                                          'date': CommonMethod().formatDate(
                                              DateTime.now(), 'MMM d, y'),
                                          'done': value
                                        });
                                      });
                                    },
                                  ),
                                ],
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        if (value.trim().isNotEmpty) {
                          setState(() {
                            isButton = true;
                          });
                        } else {
                          setState(() {
                            isButton = false;
                          });
                        }
                      },
                      onTap: () {
                        _scrollDown();
                      },
                      style: const TextStyle(color: Colors.white),
                      controller: contentController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "Add your toDo's ....",
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                        foregroundColor: isButton
                            ? const Color.fromARGB(255, 47, 227, 243)
                            : Colors.grey),
                    onPressed: () async {
                      //todoBox.clear();
                      if (isButton) {
                        Database().addTodo({
                          'content': contentController.text,
                          'date': CommonMethod()
                              .formatDate(DateTime.now(), 'MMM d, y'),
                          'done': false,
                        });
                        contentController.clear();
                        updateToDoList();
                        _scrollDown();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
