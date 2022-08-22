import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/View/api.dart';
import 'package:flutter_application_1/home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final screen = [homepage(), api()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(),
        child: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 65,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                    width: 1, color: Color.fromARGB(255, 197, 202, 233)),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomBar(
                  text: "Firebase",
                  selected: _selectedIndex == 0,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                BottomBar(
                  text: "API",
                  selected: _selectedIndex == 1,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final String text;

  final bool selected;
  final Function() onPressed;
  const BottomBar(
      {required this.text,
      required this.selected,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 5.0,
        decoration: BoxDecoration(
            color: selected ? Colors.white12 : Colors.transparent),
        child: Column(children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            width: 65,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selected ? Colors.deepPurple[200] : Colors.transparent,
            ),
            child: Align(
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: onPressed, icon: Icon(Icons.access_alarm))),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            text,
            style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 12,
                height: 0.1,
                color: selected ? Colors.black : Colors.black),
          )
        ]),
      ),
    );
  }
}
