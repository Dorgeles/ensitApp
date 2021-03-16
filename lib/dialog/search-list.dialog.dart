import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/services/customer.service.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<Customer> showCustomerListDialog(BuildContext context,
    {String title, bool showMe = false, String grade}) async {
  dynamic _value;
  TextEditingController _searchController = TextEditingController();

  final future = ParseUser.currentUser().then((user) {
    return CustomerService()
        .getAllCustomerByGrade(grade: grade)
        .then((response) {
      return response;
    });
  });

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title ?? "Choisir un compte",
          style: TextStyle(fontSize: 16),
        ),
        content: StatefulBuilder(
            builder: (BuildContext stfContext, StateSetter setState) {
          return Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Recherche...",
                  hintStyle: TextStyle(color: Colors.black38),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FutureBuilder<List<Customer>>(
                      future: future,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Customer>> snapshot) {
                        if (!snapshot.hasError) {
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 20),
                              itemCount: snapshot.data != null
                                  ? snapshot.data.length + (showMe ? 1 : 0)
                                  : 0,
                              itemBuilder: (context, index) {
                                if (index == snapshot.data.length && showMe) {
                                  return RadioListTile(
                                    title: Text(
                                      "Moi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      "Mon compte utilisateur",
                                    ),
                                    value: "me",
                                    onChanged: (dynamic value) {
                                      setState(() => _value = value);
                                    },
                                    groupValue: _value,
                                  );
                                }

                                final people = snapshot.data[index];

                                return RadioListTile(
                                  title: Text(
                                    people.firstname.toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    people.lastname.toLowerCase(),
                                  ),
                                  value: people,
                                  onChanged: (dynamic value) {
                                    setState(() => _value = value);
                                  },
                                  groupValue: _value,
                                );
                              });
                        } else {
                          return Center(child: Container(child: Text("...")));
                        }
                      })

                  //: Container(child: Text("Ajouter une Addresse")),
                  ),
            ],
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
    },
  );
}
