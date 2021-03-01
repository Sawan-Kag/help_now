import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_provider_api.dart';
import 'db_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Search");
  String searchText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(
                      Icons.close,
                      color: Colors.purple[400],
                    );
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.purple[400],
                      ),
                      onChanged: (value) {
                        searchText = value;
                      },
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.purple[400]),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.purple[400])),
                    );
                  } else {
                    this.actionIcon = new Icon(
                      Icons.search,
                      color: Colors.purple[400],
                    );
                    this.appBarTitle = new Text(
                      "SIGMA TENAT",
                      style: (TextStyle(color: Colors.purple[400])),
                    );
                  }
                });
              },
            ),
          ],
        ),
        body: _buildHomeListView(),
      ),
    );
  }

  _loadFromApi() async {
    var apiProvider = DataApiProvider();
    await apiProvider.getAllData();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAlldata();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildHomeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAlldatafromdatabase(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else  {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5), //border corner radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //color of shadow
                      spreadRadius: 2, //spread radius
                      blurRadius: 4, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    ),
                    //you can set more BoxShadow() here
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RaisedButton(
                      elevation: 6.0,
                      color: Colors.white,
                      onPressed: () async {},
                      child: Text(
                        " ${snapshot.data[index].displayName}",
                        style: TextStyle(color: Colors.purple[400]),
                      ),
                    ),
                    Text(
                      "${snapshot.data[index].meta}",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        "${snapshot.data[index].description}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "SPACE",
                      style: TextStyle(color: Colors.purple[400]),
                    )
                  ],
                ),
              );}
            },
          );
        }
      },
    );
  }

  Widget searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green[300]),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[500],
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            ),
            /*Icon(
              Icons.filter_list,
              color: Colors.lightGreen,
            ),*/
            hintText: "Indore",
            focusColor: Colors.green),
        onChanged: (value) {},
      ),
    );
  }
}

/*
ListTile(
leading: Text(
"${index + 1}",
style: TextStyle(fontSize: 20.0),
),
title: Text(
"Name: ${snapshot.data[index].id} ${snapshot.data[index].title} "),
subtitle: Text('EMAIL: ${snapshot.data[index].title}'),
);
*/
