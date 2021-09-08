import 'package:flutter/material.dart';
import 'activeOrders.dart';
import 'pendingOrders.dart';
import 'historyOrders.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.assignment_turned_in), text: 'Active'),
                Tab(icon: Icon(Icons.hourglass_empty), text: 'Pending'),
                Tab(icon: Icon(Icons.history), text: 'History'),
              ],
            ),
            title: Center(
              child: Text(
                'Orders',
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                ActiveOrders(),
                PendingOrders(),
                HistoryOrders(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
