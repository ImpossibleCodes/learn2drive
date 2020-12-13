import "package:flutter/material.dart";

class AddDrive extends StatefulWidget {
  @override
  _AddDriveState createState() => _AddDriveState();
}

class _AddDriveState extends State<AddDrive> {
  // var to store
  // onChanged callback
  String text = "No Value Entered";
  DateTime _dateTime;

  void _setText() {
    setState(() {
      //text = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Drive'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text(_dateTime == null
                      ? 'No Date Has Been Picked Yet'
                      : _dateTime.toString()),
                  RaisedButton(
                      child: Text('Pick a Date'),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2021))
                            .then(
                          (date) {
                            setState(() {
                              _dateTime = date;
                            });
                          },
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Minutes Driven'),
                      //onChanged: (value) => title = value,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Minutes Driven at Night'),
                      //onChanged: (value) => title = value,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Miles Driven'),
                      //onChanged: (value) => title = value,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Skills Worked On'),
                      //onChanged: (value) => title = value,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RaisedButton(
                    onPressed: _setText,
                    child: Text('Submit'),
                    elevation: 8,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
