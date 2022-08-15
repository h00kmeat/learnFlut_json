import 'package:flutter/material.dart';
import 'package:jsonworks/offices.dart';
import 'dart:async';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info from JSON'),
        centerTitle: true,
      ),
      body: OfficesUI(),
    );
  }
}

class OfficesUI extends StatefulWidget {
  const OfficesUI({Key? key}) : super(key: key);

  @override
  State<OfficesUI> createState() => _OfficesUIState();
}

class _OfficesUIState extends State<OfficesUI> {
  late Future<OfficesList> officesList;

  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.offices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data!.offices[index].name),
                      subtitle: Text(snapshot.data!.offices[index].address),
                      leading:
                          Image.network(snapshot.data!.offices[index].image),
                      isThreeLine: true,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return Center(child: CircularProgressIndicator(),);
        },

      ),
    );
  }
}
