import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'Database.dart';
import 'dataModel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showFab = true;
  var len;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    DBProvider.db.getAllClients();
    AsyncSnapshot<List<Client>> snapshot;
    //len = snapshot.data.length;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Client> testClients = [
    Client(
        id: "22",
        Name: "sawan1",
        Mobile: "1111111111",
        Date: "01/02/2020",
        Amount: "2000",
        Amount_type: "cash"),
    Client(
        id: "22",
        Name: "sawan2",
        Mobile: "2222222222",
        Date: "01/02/2020",
        Amount: "3456",
        Amount_type: "cash"),
    Client(
        Name: "sawan3",
        Mobile: "3333333333",
        Date: "01/02/2020",
        Amount: "3334",
        Amount_type: "cash"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showFab
          ? FloatingActionButton(
              child: Icon(Icons.import_export_outlined),
              onPressed: () {
                _showForm(context);
              },
            )
          : null,
      body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            setState(() {
              if (notification.direction == ScrollDirection.forward) {
                showFab = true;
              } else if (notification.direction == ScrollDirection.reverse) {
                showFab = false;
              }
            });
            return true;
          },
          child: lists()),
    );
  }

  void _showForm(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.add),
                      title: new Text('ADD User'),
                      onTap: () async {
                        Client rnd = testClients[1];
                        await DBProvider.db.newClient(rnd);
                        setState(() {});
                        print(
                            'ooooooooooooooooooooooooooooooooooooooooookkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.arrow_upward),
                    title: new Text('EXPORT Data'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget circleImage() {
    return CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTExtoLVhMIfPRj_8d5RQKF2qjwUbuYL2tZTg&usqp=CAU"),
      backgroundColor: Colors.transparent,
    );
  }

  ListView lists() {
    return ListView.separated(
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(4, 8), // changes position of shadow
              ),
            ],
          ),
          height: 120,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              circleImage(),
              SizedBox(
                width: 20,
              ),
              detailsColumn(index),
              SizedBox(
                width: 5,
              ),
              amountContainer(),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: 8,
    );
  }

  Widget detailsColumn(index) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.person_rounded),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  "SAWAN KAG",
                  style: TextStyle(
                    fontFamily: 'Akaya',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(
                width: 5,
              ),
              Text(
                "9994652841",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            height: 20,
            // indent: 20,
            // endIndent: 20,
            color: Colors.black,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " DATE : ",
                style: TextStyle(fontSize: 10),
              ),
              Text(
                "01/02/2020",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget amountContainer() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "AMOUNT",
            style: TextStyle(fontFamily: 'Akaya', fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "2000",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text("Type"),
        ],
      ),
    );
  }
}
