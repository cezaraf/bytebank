import 'package:bytebank/screens/contact/contact_list.screen.dart';
import 'package:bytebank/screens/transaction/transaction_list.screen.dart';
import 'package:bytebank/screens/transfer/transfer_list.screen.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _FeatureItem(
                  'Transfer',
                  Icons.monetization_on,
                  onClick: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactsList())),
                ),
                _FeatureItem(
                  'Transfer feed',
                  Icons.description,
                  onClick: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionsList())),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData iconData;
  final Function onClick;

  const _FeatureItem(this.name, this.iconData, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => this.onClick(),
          child: Container(
            height: 100,
            width: 150,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  this.iconData,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  this.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
