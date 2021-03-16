import 'package:flutter/material.dart';

Future<String> radioDialog(
    BuildContext context, List<String> list, String title) {
  String _value;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: StatefulBuilder(
              builder: (BuildContext stfContext, StateSetter setState) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: ((context, index) {
                  final choice = list[index];
                  if (choice != null) {
                    return RadioListTile(
                      title: Text(
                        list[index].toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      value: choice,
                      onChanged: (dynamic value) {
                        setState(() => _value = value);
                      },
                      groupValue: _value,
                    );
                  } else {
                    return null;
                  }
                }),
              ),
            );
          }),
          actions: [
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Fermer'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(_value);
                  },
                  child: Text('OK'),
                ),
              ],
            )
          ],
        );
      });
}

Future<String> radioClassDialog(BuildContext context) {
  List<String> list = [
    "Prépa 1",
    "Prépa 2",
    "Ingénieur 1",
    "Ingénieur 2",
    "Ingénieur 3",
  ];
  String _value;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choisir le niveau"),
          content: StatefulBuilder(
              builder: (BuildContext stfContext, StateSetter setState) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: ((context, index) {
                  final choice = list[index];
                  if (choice != null) {
                    return RadioListTile(
                      title: Text(
                        list[index].toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      value: choice,
                      onChanged: (dynamic value) {
                        setState(() => _value = value);
                      },
                      groupValue: _value,
                    );
                  } else {
                    return null;
                  }
                }),
              ),
            );
          }),
          actions: [
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Fermer'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(_value);
                  },
                  child: Text('OK'),
                ),
              ],
            )
          ],
        );
      });
}
