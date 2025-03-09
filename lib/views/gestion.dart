import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tile.dart';

class VehicleRentalScreen extends StatefulWidget {
  final String token;

  const VehicleRentalScreen({Key? key, required this.token}) : super(key: key);

  @override
  _VehicleRentalScreenState createState() => _VehicleRentalScreenState();
}

class _VehicleRentalScreenState extends State<VehicleRentalScreen> {
  List<dynamic> vehicles = [];

  @override
  void initState() {
    super.initState();
    _fetchVehicles();
  }

  Future<void> _fetchVehicles() async {
    final url = Uri.parse('http://localhost:5000/api/vehiculos');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          vehicles = jsonDecode(response.body);
        });
      } else {
        print("Error al obtener vehículos: ${response.body}");
      }
    } catch (e) {
      print("Error de conexión: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alquiler de Vehículos")),
      body: vehicles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return VehicleTile(
                  vehicleId: vehicle['_id'] ?? '',
                  vehicleName: vehicle['marca'] + " " + vehicle['modelo'],
                  year: vehicle['anio'] ?? 0,
                  availability: vehicle['disponibilidad'] ?? 'no',
                  onRent: (id) {
                    print("Intentando alquilar el vehículo: $id");
                  },
                );
              },
            ),
    );
  }
}
