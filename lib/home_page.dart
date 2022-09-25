import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hibit_tracker_koko/utils/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    //[habitName, habitstarted, timeSpent(sec), timeGoal(min)]
    ['Exs', false, 0, 1],
    ['Read', false, 2, 1],
    ['Meditate', false, 0, 1],
    ['Code', false, 0, 1],
  ];
  //functionn setting
  void tapSetting(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Settings for' + habitList[index][0]),
        );
      },
    );
  }

  //function ontap habit started
  void habitStarted(int index) {
    //already elapsed time
    int elapsedTime = habitList[index][2];
    //change the state
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });
    //get the time when it is clicked
    var startTime = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (!habitList[index][1]) {
          timer.cancel();
        }
        //calculate the no of seconds
        var currentTime = DateTime.now();
        habitList[index][2] = (currentTime.second - startTime.second) +
            60 * (currentTime.minute - startTime.minute) +
            60 * 60 * (currentTime.hour - startTime.hour) +
            elapsedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Consistency is Key!'),
          backgroundColor: Colors.grey[900],
        ),
        body: ListView.builder(
          itemCount: habitList.length,
          itemBuilder: (context, index) {
            return HabitTile(
              habitName: habitList[index][0],
              timeGoal: habitList[index][3],
              timeSpent: habitList[index][2],
              isHabitStarted: habitList[index][1],
              settingTap: () => tapSetting(index),
              ontap: () => habitStarted(index),
            );
          },
        ));
  }
}
