import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Customer{
  int _id;
  String _name;
  String _location;
  List<Order> _orders;

  Customer(this._id, this._name, this._location, this._orders);
  Customer.empty() : this(0, "", "", []);

  int get id{
    return _id;
  }

  String get name{
    return _name;
  }

  String get location{
    return _location;
  }

  List<Order> get orders{
    return _orders;
  }
}

class Order{
  int _id;
  String _description;
  DateTime _dt;
  double _total;

  Order(this._id, this._dt, this._description, this._total);
  Order.empty() : this(0, DateTime.now(), "", 0.0);

  int get id{
    return _id;
  }

  String get description{
    return _description;
  }

  DateTime get dt{
    return _dt;
  }

  double get total{
    return _total;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route<dynamic> handleRoute(RouteSettings routeSettings){
    List<String> nameParam = routeSettings.name!.split(":");
    assert(nameParam.length==2);
    String name = nameParam[0];
    assert(name!=null);
    int id = int.parse(nameParam[1]);
    assert(id!=null);
    Widget childWidget;
    if(name=="/order/"){
      childWidget = OrderWidget(id);
    }
    else{
      childWidget = CustomerWidget(id);
    }
    return MaterialPageRoute(builder: (context)=>DataContainerWidget(child: childWidget));
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataContainerWidget(child: HomeWidget(),),
      onGenerateRoute: handleRoute,
    );
  }
}

class DataContainerWidget extends InheritedWidget{
   DataContainerWidget({
    required Widget child, }) : super( child: child);

  final List<Customer> _customerList = [ Customer(1, "Bike Corp", "Atlanta", [
    Order(11, DateTime(2018, 11, 17), "Bicycle parts", 197.02),
    Order(12, DateTime(2018, 12, 1), "Bicycle parts", 107.45), ]),
    Customer(2, "Trust Corp", "Atlanta", [
      Order(13, DateTime(2017, 1, 3), "Shredder parts", 97.02), Order(14, DateTime(2018, 3, 13), "Shredder blade", 7.45), Order(15, DateTime(2018, 5, 2), "Shredder blade", 7.45),
    ]),
    Customer(3, "Jilly Boutique", "Birmingham", [
      Order(16, DateTime(2018, 1, 3), "Display unit", 97.01), Order(17, DateTime(2018, 3, 3), "Desk unit", 12.25), Order(18, DateTime(2018, 3, 21), "Clothes rack", 97.15),
    ]), ];

  List<Customer> get customerList => _customerList;
  Customer getCustomer(int id) {
    return _customerList.firstWhere((customer) => customer.id == id,
        orElse: () => Customer.empty());
  }

  Customer getCustomerForOrderId(int id) {
    return customerList.firstWhere(
          (customer) => customerHasOrderId(customer, id),
      orElse: () => Customer.empty());
  }

  Order getOrder(int id) {
    Customer customerThatOwnsOrder = getCustomerForOrderId(id); return customerThatOwnsOrder.orders
        .firstWhere((order) => order.id == id, orElse: () => Order.empty());
  }

  bool customerHasOrderId(Customer customer, int id) {
    Order order = customer.orders
      .firstWhere((order) => order.id == id, orElse: () => Order.empty()); return order.id != 0;
  }

  static DataContainerWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataContainerWidget>()
    as DataContainerWidget;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}


class HomeWidget extends StatelessWidget {
  HomeWidget() : super();
  void navigateToCustomer(BuildContext context, Customer customer) { Navigator.pushNamed(context, '/customer/:${customer.id}');
  }
  ListTile createCustomerWidget(BuildContext context, Customer customer) { 
    return ListTile(
        title: Text(customer.name),
        subtitle: Text(customer.location),
        trailing: Icon(Icons.arrow_right),
        onTap: () => navigateToCustomer(context, customer));
  }
  @override
  Widget build(BuildContext context) {
    DataContainerWidget data = DataContainerWidget.of(context); List<Widget> customerList = List.from(data.customerList
        .map((Customer customer) => createCustomerWidget(context, customer))); 
    return Scaffold(
        appBar: AppBar(
          title: const Text("Customers"),
        ),
        body: Center(
          child: ListView( children: customerList,
          ), ));
  }
}

class CustomerWidget extends StatelessWidget { 
  int _id;
  CustomerWidget(this._id);
void navigateToOrder(BuildContext context, Order order) { Navigator.pushNamed(context, '/order/:${order.id}');
}
ListTile createOrderListWidget(BuildContext context, Order order) { return ListTile(
    title: Text(order.description),
    subtitle: Text("${order.dt.month}/${order.dt.day}/${order.dt.year}: "
        "\$${order.total}"),
    trailing: Icon(Icons.arrow_right),
    onTap: () => navigateToOrder(context, order));
}
@override
Widget build(BuildContext context) {
  DataContainerWidget data = DataContainerWidget.of(context); Customer customer = data.getCustomer(_id);
  List<Widget> orderListWidgets = List.from(customer.orders
      .map((Order order) => createOrderListWidget(context, order))); orderListWidgets.insert(
      0, Container(
      child: Column( children: <Widget>[
        Text(
          customer.name,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ), Text(
          customer.location,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), ),
        Text(
          "${customer.orders.length} Orders",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ) ],
      ),
      padding: EdgeInsets.all(20.0))); return new Scaffold(
      appBar: new AppBar(
        title: new Text("Customer Info"),
      ),
      body: new Center(
        child: new ListView( children: orderListWidgets,
        ), ));
} }
class OrderWidget extends StatelessWidget { int _id;

OrderWidget(this._id);
@override
Widget build(BuildContext context) {
  DataContainerWidget? data = context.dependOnInheritedWidgetOfExactType<DataContainerWidget>();
  Customer customer = Customer.empty();

  if(data!=null){
    customer = data.getCustomerForOrderId(_id);
  }
  Order order = Order.empty();
  if(data!=null){
    print(data.getOrder(_id));
    order = data.getOrder(_id);
  }
  return Scaffold(
      appBar:  AppBar(
        title:  Text("Order Info"),
      ),
      body:  Padding(
        padding: EdgeInsets.all(20.0), child: new ListView(
        children: <Widget>[ Text(customer.name,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center), Text(customer.location,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center), Text(""),
          Text(order.description,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          Text(
              "${order.dt.month}/${order.dt.day}/${order.dt.year} \$${order.total}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center) ],
      ), ));

} }
