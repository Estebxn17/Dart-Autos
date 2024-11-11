import 'package:flutter/material.dart';
import 'tile.dart';
import 'package:flutter_autos/views/usuario.dart';

class VehicleRentalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Alquiler de Vehículos'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Inicio'), onTap: () {}),
            ListTile(leading: Icon(Icons.directions_car), title: Text('Alquiler'), onTap: () {}),
            ListTile(leading: Icon(Icons.person), title: Text('Usuario'), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            })
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar vehículo',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  VehicleTile(vehicleName: 'Toyota Corolla', year: 2022, availability: 'Disponible'),
                  VehicleTile(vehicleName: 'Nissan Sentra', year: 2021, availability: 'Disponible'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Alquiler'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuario'),
        ],
     ),
);
}
}