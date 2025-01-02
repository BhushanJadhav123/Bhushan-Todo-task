import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TimerDropDown extends StatelessWidget {
  const TimerDropDown({
    super.key,
    required this.slectedTimerCallBack,
    required this.timerOptions,
    required this.selectedValue,
  });
  final Function(String?) slectedTimerCallBack;
  final List<String> timerOptions;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: DropdownButton<String>(
        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        style: const TextStyle(fontSize: 20, color: Colors.black),
        underline: Container(),
        focusColor: Colors.blue,
        alignment: Alignment.topCenter,
        dropdownColor: Colors.white,
        isExpanded: true,
        elevation: 10,
        value: selectedValue,
        items: timerOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newStatus) {
          slectedTimerCallBack(newStatus);
        },
      ),
    );
  }
}

/// Selecting minutes with the help of this dropdown.
class MinutesSelectionDropDown extends StatefulWidget {
  const MinutesSelectionDropDown(
      {super.key, required this.slectedTimerCallBack, this.selectedMinute});
  final Function(int) slectedTimerCallBack;
  final int? selectedMinute;
  @override
  State<MinutesSelectionDropDown> createState() =>
      _MinutesSelectuonDropDownState();
}

class _MinutesSelectuonDropDownState extends State<MinutesSelectionDropDown> {
  final List<String> timerOptions = [
    "0 minute",
    "1 minute",
    "2 minute",
    "3 minute",
    "4 minute"
  ];
  late String selectedValue;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    selectedValue = widget.selectedMinute != null
        ? "${widget.selectedMinute} minute"
        : timerOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return TimerDropDown(
      selectedValue: selectedValue,
      slectedTimerCallBack: (newStatus) {
        setState(() {
          selectedValue = newStatus ?? "0 minute";
          if (newStatus == "0 minute") {
            widget.slectedTimerCallBack(0);
          } else if (newStatus == "1 minute") {
            widget.slectedTimerCallBack(1);
          } else if (newStatus == "2 minute") {
            widget.slectedTimerCallBack(2);
          } else if (newStatus == "3 minute") {
            widget.slectedTimerCallBack(3);
          } else {
            widget.slectedTimerCallBack(4);
          }
        });
      },
      timerOptions: timerOptions,
    );
  }
}

/// Second Selection Dropdowna
class SecondSelectionDropDown extends StatefulWidget {
  const SecondSelectionDropDown(
      {super.key, required this.slectedTimerCallBack, this.selectedSecond});
  final Function(int) slectedTimerCallBack;
  final int? selectedSecond;
  @override
  State<SecondSelectionDropDown> createState() =>
      _SecondSelectionDropDownState();
}

class _SecondSelectionDropDownState extends State<SecondSelectionDropDown> {
  final List<String> timerOptions = List.generate(60, (index) => "$index sec");
  late String selectedValue;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    selectedValue = widget.selectedSecond != null
        ? "${widget.selectedSecond} sec"
        : timerOptions[timerOptions.length - 1];
  }

  @override
  Widget build(BuildContext context) {
    return TimerDropDown(
      selectedValue: selectedValue,
      slectedTimerCallBack: (selectedSecond) {
        setState(() {
          selectedValue = selectedSecond ?? "0 sec";
          final splitedList = selectedValue.split(" ");
          final int secondsInInteger = int.parse(splitedList[0]);
          widget.slectedTimerCallBack(secondsInInteger);
        });
      },
      timerOptions: timerOptions,
    );
  }
}
