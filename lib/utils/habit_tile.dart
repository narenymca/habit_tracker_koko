import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback ontap;
  final VoidCallback settingTap;
  final int timeSpent;
  final int timeGoal;
  final bool isHabitStarted;
  const HabitTile({
    Key? key,
    required this.habitName,
    required this.timeGoal,
    required this.timeSpent,
    required this.isHabitStarted,
    required this.settingTap,
    required this.ontap,
  }) : super(key: key);

  String secToMin(int totalsec) {
    String sec = (totalsec % 60).toString().padLeft(2, '0');
    String min = (totalsec / 60).floor().toString();
    return min + ':' + sec;
  }

  double percentagecalc() {
    return timeSpent / timeGoal * 1 / 60;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: ontap,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 20,
                          percent:
                              (percentagecalc() < 1) ? percentagecalc() : 1,
                          progressColor: (percentagecalc() > 0.5)
                              ? Colors.green
                              : Colors.red,
                        ),
                        Center(
                            child: Icon(isHabitStarted
                                ? Icons.play_arrow
                                : Icons.pause)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      secToMin(timeSpent) + '/' + timeGoal.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: settingTap,
              icon: Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }
}
