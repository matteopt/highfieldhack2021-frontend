import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:healthyapp/requests.dart';
import 'package:http/http.dart' as http;

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  String _exercise = null;
  List<String> _people = [];
  List<Map<String, dynamic>> _friends = [
    {
    'id': 'sk3',
    'name': 'Jeff',
    'brand': '',
    'category': 'Your Friends'
  },
  ];

  List<S2Choice<String>> _exercises = [
  S2Choice<String>(value: '1', title: 'Running'),
  S2Choice<String>(value: '2', title: 'Cycling'),
  S2Choice<String>(value: '3', title: 'Rope-skipping'),
  S2Choice<String>(value: '4', title: 'Push-ups'),
  S2Choice<String>(value: '5', title: 'Walk yourself'),
];

DateTime _selectedDate = DateTime.now();


Future<Null> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2022));
    if (picked != null)
      setState(() {
       _selectedDate = picked;
      });
  }

  void _getFriends() async {
    http.Response response = await getFriends(widget.username);
  }

  @override
  void initState() {
    super.initState();

    _getFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Create a new task",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            child: SmartSelect<String>.single(
              title: 'Exercise type',
              value: _exercise,
              choiceItems: _exercises,
              onChange: (selected) => setState(() => _exercise = selected.value),
              modalType: S2ModalType.bottomSheet,
              tileBuilder: (context, state) {
                return S2Tile.fromState(
                  state,
                  isTwoLine: true,
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://cdn0.iconfinder.com/data/icons/sports-and-fitness/512/barbell_dumbbell_strength_workout_weight_gym_weightlifting_equipment_bodybuilding_fitness_lifting_strong_sport_exercise_training_flat_design_icon-512.png',
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 30,),
          SmartSelect<String>.multiple(
            title: 'Friends',
            placeholder: 'Choose one or more',
            value: _people,
            onChange: (selected) {
              setState(() => _people = selected.value);
            },
            choiceItems: S2Choice.listFrom<String, Map>(
              source: _friends,
              value: (index, item) => item['id'],
              title: (index, item) => item['name'],
              group: (index, item) => item['category'],
            ),
            choiceGrouped: true,
            modalType: S2ModalType.bottomSheet,
            modalFilter: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isTwoLine: true,
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://image.flaticon.com/icons/png/512/1946/1946716.png',
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Deadline: " + (_selectedDate == null ? "choose a deadline" : _selectedDate.toString().split(" ")[0]),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    _selectDate(context);
                  },
                  child: Text("CHOOSE DATE", style: TextStyle(color: Colors.blue, ),),
                ),
              ],
            ),
            
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Slider(
    value: _currentSliderValue,
    min: 0,
    max: 100,
    divisions: 5,
    label: _currentSliderValue.round().toString(),
    onChanged: (double value) {
      setState(() {
        _currentSliderValue = value;
      });
    },
  );

                ],
              ),
            )
        ],
      ),
    );
  }
}