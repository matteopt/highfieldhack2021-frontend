import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:healthyapp/requests.dart';
import 'package:http/http.dart' as http;

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();

  CreateTaskPage({Key key, @required this.username});

  final String username;
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  
  String _exercise = null;

  double _currentSliderValue = 2;

  List<String> _people = [];
  
  List<Map<String, dynamic>> _friends = [];

  List<S2Choice<String>> _exercises = [
    S2Choice<String>(value: '1', title: 'Running'),
    S2Choice<String>(value: '2', title: 'Cycling'),
    S2Choice<String>(value: '3', title: 'Rope-skipping'),
    S2Choice<String>(value: '4', title: 'Push-ups'),
    S2Choice<String>(value: '5', title: 'Meditate'),
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
    List<String> t;
    
    if (response.body == '521' || response.body == '522') {
      setState(() {
        t = [];
      });
    } else {
      setState(() {
        t = response.body.split(" ");
      });
    }

    t.forEach((u) {
      _friends.add({
        'id': u,
        'name': u,
        'brand': '',
        'category': 'Your Friends',
      });
    });

    setState(() {});
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
          SizedBox(height: 10,),
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
          SizedBox(height: 10,),
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
          SizedBox(height: 15,),
          ListTile(
            onTap: () async {
                    _selectDate(context);
                  },
            dense: true,
            title: Text(
              "Choose Date",
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w400,
                )),
            subtitle: Text(
              "Deadline: " + (_selectedDate == null ? "choose a deadline" : _selectedDate.toString().split(" ")[0]),
              style: TextStyle(
                fontSize: 13.7,
                fontWeight: FontWeight.w400
                )),
            leading: Image(
              image: NetworkImage('https://files.catbox.moe/nu9j0k.png'),
              height: 42,),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Slider(
                    value: _currentSliderValue,
                    min: 2,
                    max: 50,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    _currentSliderValue.round().toString() + " miles"
                  ),
                )
              ],
            ),
          ),
          

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  http.Response response = await sendChallenge(widget.username, _people, _exercise, _currentSliderValue.round(), _selectedDate.toString().split(" ")[0]);
                  print(response.body);
                },
                elevation: 5,
                child: Text(
                  "CREATE",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              ),
            ),
          )
          
        ],
      ),
    );
  }
}