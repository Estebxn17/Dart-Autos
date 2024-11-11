import 'package:flutter/material.dart';
import 'payment.dart';

class VehicleDetailScreen extends StatelessWidget {
  final String vehicleName;
  final int year;
  final String availability;

  const VehicleDetailScreen({
    Key? key,
    required this.vehicleName,
    required this.year,
    required this.availability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Detalle del Vehículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.directions_car, size: 100, color: Colors.redAccent),
            ),
            SizedBox(height: 20),
            Text('Marca: Toyota', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Modelo: $vehicleName', style: TextStyle(fontSize: 16)),
            Text('Año: $year', style: TextStyle(fontSize: 16)),
            Text('Disponibilidad: $availability', style: TextStyle(fontSize: 16, color: Colors.green)),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.car_rental),
                label: Text('Alquilar Vehículo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
                  );
                },
              ),
            ),
          ],
        ),
     ),
);
}
}