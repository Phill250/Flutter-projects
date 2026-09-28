import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom/model/cart.dart';
import 'package:vroom/model/product.dart';
import 'package:vroom/screens/cart_card.dart';
import 'package:vroom/screens/product_card.dart';
import 'package:vroom/viewmodel/auth_viewmodel.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _tabTitle = 'Home';

  final List<Widget> _tabs = [
    _HomeTab(),
    _CartTab(),
    _OrdersTab(),
    _ProfileTab(),
  ];
  final List<String> _titles = ['Home', 'Cart', 'Orders', 'Profile'];

  void _onTabClicked(int index) {
    setState(() {
      _selectedIndex = index;
      _tabTitle = _titles[index];
    });
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(_tabTitle),
        Row(children: [
          Spacer(flex: 1),

       
      Consumer<CartModel>(builder: (context, cart, child){
        return Text('Order Total: KES ${cart.getTotalCost()}',
        style: TextStyle(fontSize: 12),
        );

      }),
        ]
      ),
        ]
      ),
      ),
      

      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabClicked,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final product = dummyProducts[index];
        return ProductCard(product: product);
      },
    );
  }
}

class _CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          return Center(child: Text('Your cart is empty'));
        }

        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final cartItem = cart.items[index];
            return CartCard(cartItem: cartItem,
            increment: (){
              cart.increment(cartItem.product);

},
            decrement: (){
              cart.decrement(cartItem.product);
            },);

          },
        );
      },
    );
  }
}

class _OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Orders'));
  }
}

class _ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel> (builder: (_,authViewModel, _){
      return Center(
        child: ElevatedButton(onPressed: () {
          authViewModel.logout();

        },
        child: Text('Log out'),
        ),
      );
    },
    );
  }
}



//ephemeral state: confined on a single screen.
