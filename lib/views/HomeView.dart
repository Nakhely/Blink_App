
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/views/CreatePostView.dart';
import 'package:flutter_app/views/ProfileView.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeView extends StatefulWidget {
  final User user;
  HomeView({Key key, this.user}) : super(key : key);

  @override
  _HomeView createState() => _HomeView();

}

class _HomeView extends State<HomeView> {
  int _currentIndex = 0;
  List<Widget> tabs;

  @override
  void initState() {
    tabs = [
      Center (child: Text('sida')),
      CreatePostView (),
      ProfileView(user: widget.user)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Container(
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar (
        iconSize: 30,
        backgroundColor: Color.fromRGBO(53, 50, 69, 1),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(OMIcons.home, color: Color.fromRGBO(210, 206, 229, 1)),
            activeIcon: Icon(Icons.home, color: Color.fromRGBO(210, 206, 229, 1)),
            title: Text('Home', style: TextStyle (color: Color.fromRGBO(210, 206, 229, 1)),),
          ),

          BottomNavigationBarItem(
            icon: Icon(OMIcons.addBox, color: Color.fromRGBO(210, 206, 229, 1)),
            activeIcon: Icon(Icons.add_box, color: Color.fromRGBO(210, 206, 229, 1)),
            title: Text('Home', style: TextStyle (color: Color.fromRGBO(210, 206, 229, 1)),),
          ),

          BottomNavigationBarItem (
            icon: Icon(OMIcons.accountCircle, color: Color.fromRGBO(210, 206, 229, 1)),
            activeIcon: Icon(Icons.account_circle, color: Color.fromRGBO(210, 206, 229, 1)),
            backgroundColor: Color.fromRGBO(53, 50, 69, 1),
            title: Text('Profile', style: TextStyle(color: Color.fromRGBO(210, 206, 229, 1))),
          )
        ],

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

      ),
    );
  }

}