import 'package:flutter/material.dart';
import 'package:task_minder/pages/pages.dart';

import 'home_page_components/home_page_components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: MediaQuery.of(context).size.height / 4,
        title: const ListTile(
          title: Text(
            'TASK MINDER',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          subtitle: Text('"The best way to get something\ndone is to begin." '),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white.withOpacity(0.5)),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(250))),
      ),
      backgroundColor: const Color.fromRGBO(19, 24, 38, 1),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Opacity(opacity: 0.2, child: CircularPattern()),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AboutPage()));
              },
              child: Image.asset(
                'assets/verify.png',
                color: const Color.fromARGB(255, 197, 215, 114),
                height: 50,
                width: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ToDoPage()));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 110, 186, 113),
                      ),
                      child: Image.asset(
                        'assets/to-do-list.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ExpenceTracker()));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 110, 131, 186),
                      ),
                      child: Image.asset(
                        'assets/indian-rupee.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
