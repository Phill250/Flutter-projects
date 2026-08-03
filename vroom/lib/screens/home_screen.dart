import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState(){
    return _HomeScreenState();
  }


}


class _HomeScreenState extends State<HomeScreen>{

  int _SelectedIndex = 0;
  String _tabTitle = 'Home';

  final List<Widget> _tabs = [_HomeTab(), _OrdersTab(), _profileTab() ];
  final List<String> _titles = ['Home', 'Orders', 'Profile'];

  void _onTabClicked(int index){
    setState(() {
      _SelectedIndex = index;
      _tabTitle = _titles[index];
    });

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(_tabTitle)),
      body: IndexedStack(index: _SelectedIndex, children: _tabs,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _SelectedIndex,
        onTap: _onTabClicked,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home'),
      
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Orders',
            
            ),

          BottomNavigationBarItem(
            icon:Icon(Icons.person_2_outlined),
             activeIcon: Icon(Icons.person_2),
            label: 'Profile'),
      
        ]),
    );
  }
 
}

class _HomeTab extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Center(child: Text('Home'));
  }
}

class _OrdersTab extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Center(child: Text('Orders'));
  }
}

class _profileTab extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Center(child: Text('Profile'));
  }
}