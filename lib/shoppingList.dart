import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Flutter Tutorial',
    home: new MyApp(),
  ));
}
class MyApp extends StatefulWidget {

  @override
  TutorialHome createState() => new TutorialHome();
}
class TutorialHome extends State<MyApp> {
    int _selectedIndex = 0;
    @visibleForTesting
    
    static const TextStyle optionStyle = TextStyle(fontSize:30,fontWeight:FontWeight.bold);
     List<Widget> _widgetOptions = <Widget>[
      new Container(
        child:new ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[ 
            new Container(
              width: 160.0,
              color: Colors.red,
            ),
            new Container(
              width: 160.0,
              color: Colors.blue,
            ),
            new Container(
              width: 160.0,
              color: Colors.green,
            ),
            new Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            new Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        )
      ),
      new ListText(items: new List<String>.generate(10000, (i) => "Item $i"),)
    ];
    void _onTapSelected(int index){
      setState((){
          _selectedIndex = index;
      });
    }
    var that=TutorialHome;
    @override
    Widget build(BuildContext context) {
      //Scaffold是Material中主要的布局组件.
      return new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null,
          ),
          title: new Text('Example title'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        //body占屏幕的大部分
        body: new Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: new FloatingActionButton(
          tooltip: 'Add', // used by assistive technologies
          child: new Icon(Icons.add),
          onPressed: null,
        ),
        
        bottomNavigationBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: "我的1")
          ],
          currentIndex: _selectedIndex,
          activeColor : Colors.amber[800],
          onTap: _onTapSelected,
        ),
      );
    }
          
}

class Product {
  const Product ({this.name});
  final String name;
}
typedef void CartChangeCallback(Product product,bool inCart);
class ShoppingListItem extends StatelessWidget  {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));
  final Product product;
  final bool inCart;
  final CartChangeCallback onCartChanged;
  Color _getColor(BuildContext context){
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }
  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context){
    return new ListTile(
      onTap: (){
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}
class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time a widget appears at a given
  // location in the tree. If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework will re-use the State object
  // instead of creating a new State object.

  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When user changes what is in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.

      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

class ListText extends StatelessWidget{
  final List<String> items;
  ListText({Key key,@required this.items}) :super(key: key);
  @override 
  Widget build(BuildContext context){
    return Container(
      child: new ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return ListTile(
            title: new Text("${items[index]}"),
          );
        },
      ),
    );
  }
}