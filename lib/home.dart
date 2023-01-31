import 'package:flutter/material.dart';
import 'package:habit_tracker/Controller/inventory.dart';
import 'package:habit_tracker/utils.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DateTime day1 = DateTime.now().subtract(new Duration(days: 4));

  final DateTime day2 = DateTime.now().subtract(new Duration(days: 3));

  final DateTime day3 = DateTime.now().subtract(new Duration(days: 2));

  final DateTime day4 = DateTime.now().subtract(new Duration(days: 1));

  final DateTime day5 = DateTime.now();

  String _habit;

  List<Inventory> _inventory = [];

  @override
  void initState() {
    _inventory.addAll(Hive.box('inventory').values.cast<Inventory>());
    super.initState();
  }

  void addHabit(String habit, DateTime date) {
    Hive.box('inventory')
        .add(Inventory(habit, date.millisecondsSinceEpoch.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final a = 0.78;
    TextEditingController nameController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  child: new AlertDialog(
                    title: new Text('Habit Name'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter habit name"
                            ),
                            controller: nameController,
                            keyboardType: TextInputType.text,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              DateTime date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              setState(() {
                                selectedDate = date;
                              });
                            },
                            child: Text("Select Start Date"),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                addHabit(nameController.text, selectedDate);
                                print(nameController.text);
                                print(selectedDate);
                                nameController.clear();
                              },
                              child: Text("Submit"))
                        ],
                      ),
                    ),
                  ));
            },
            color: Colors.black,
            iconSize: 35.0,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
                color: Colors.black,
                padding: EdgeInsets.only(right: 15.0),
                iconSize: 35.0),
          ],
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                        child: Text('Habit',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FormattedDate(day: day1),
                ),
                Expanded(flex: 1, child: FormattedDate(day: day2)),
                Expanded(
                  flex: 1,
                  child: FormattedDate(day: day3),
                ),
                Expanded(flex: 1, child: FormattedDate(day: day4)),
                Expanded(flex: 1, child: FormattedDate(day: day5)),
                SizedBox(
                  width: data.size.width / 20,
                )
              ],
            ),
            SizedBox(
              height: data.size.height / 35,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Inventory item = _inventory[index];

                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          //width: data.size.width / 1.11,
                          height: data.size.height / 10,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: getColorFromHex('#f8f8f8'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          width: data.size.width * a,
                          alignment: Alignment.topLeft,
                          height: data.size.height / 10,
                          decoration: BoxDecoration(
                            color: getColorFromHex('#ddffcc'),
                            //borderRadius: BorderRadius.circular(10.0),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        Container(
                          //width: data.size.width / 1.11,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: data.size.width / 30,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "78%",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    Expanded(flex: 1, child: ChangeIcon()),
                                    Expanded(flex: 1, child: ChangeIcon()),
                                    Expanded(flex: 1, child: ChangeIcon()),
                                    Expanded(flex: 1, child: ChangeIcon()),
                                    Expanded(flex: 1, child: ChangeIcon()),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 0.0, 10.0),
                                  child: Text(
                                    item.habit,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: _inventory.length,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ChangeIcon extends StatefulWidget {
  const ChangeIcon({
    Key key,
  }) : super(key: key);

  @override
  _ChangeIconState createState() => _ChangeIconState();
}

class _ChangeIconState extends State<ChangeIcon> {
  bool checkValue = false;

  Widget build(BuildContext context) {
    return IconButton(
      icon: checkValue
          ? Icon(
              Icons.stop_circle,
              color: Colors.blueGrey,
            )
          : Icon(Icons.check),
      onPressed: () {
        setState(() {
          checkValue = true;
        });
      },
    );
  }
}

class FormattedDate extends StatelessWidget {
  const FormattedDate({
    Key key,
    @required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day.day.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(returnMonth(day),
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ))
      ],
    );
  }
}

String returnMonth(DateTime date) {
  return new DateFormat.MMM().format(date);
}
