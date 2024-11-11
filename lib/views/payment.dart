import 'package:flutter/material.dart';
import 'card.dart';
import 'paypal.dart';
import 'bank.dart';

class PaymentMethodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Medio de Pago'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.redAccent),
            title: Text('Tarjeta de Crédito o Débito'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreditCardScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_balance_wallet, color: Colors.redAccent),
            title: Text('PayPal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PayPalScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_balance, color: Colors.redAccent),
            title: Text('Transferencia Bancaria'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BankTransferScreen()),
              );
            },
          ),
        ],
     ),
);
}
}