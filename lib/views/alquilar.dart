import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tile.dart';

class VehiculosScreen extends StatefulWidget {
  final String token;

  const VehiculosScreen({Key? key, required this.token}) : super(key: key);

  @override
  _VehiculosScreenState createState() => _VehiculosScreenState();
}

class _VehiculosScreenState extends State<VehiculosScreen> {
  List<dynamic> _vehiculos = [];
  bool _isLoading = true;
  final String _baseUrl = "http://10.0.2.2:5000"; // Cambiar por IP real

  @override
  void initState() {
    super.initState();
    _cargarDatosIniciales();
  }

  Future<void> _cargarDatosIniciales() async {
    try {
      await _obtenerVehiculos();
    } catch (e) {
      _mostrarError(e.toString());
    }
  }

  Future<void> _obtenerVehiculos() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/vehiculos'),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _vehiculos = List.from(data);
          _isLoading = false;
        });
      } else {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> _alquilarVehiculo(String vehiculoId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/vehiculos/alquilar/$vehiculoId'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        await _obtenerVehiculos();
        _mostrarExito(responseData['message']);
      } else {
        throw Exception(responseData['message']);
      }
    } catch (e) {
      _mostrarError(e.toString());
    }
  }

  void _mostrarExito(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Vehículos'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _buildContenidoPrincipal(),
    );
  }

  Widget _buildContenidoPrincipal() {
    return RefreshIndicator(
      onRefresh: _obtenerVehiculos,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _vehiculos.isEmpty
              ? const Center(child: Text('No hay vehículos disponibles'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _vehiculos.length,
                  itemBuilder: (context, index) {
                    final vehiculo = _vehiculos[index];
                    return VehicleTile(
                      key: Key(vehiculo['_id'] + DateTime.now().toString()),
                      vehicleId: vehiculo['_id'],
                      vehicleName: '${vehiculo['marca']} ${vehiculo['modelo']}',
                      year: vehiculo['anio'],
                      availability: vehiculo['disponibilidad'],
                      onRent: _alquilarVehiculo,
                    );
                  },
                ),
    );
  }
}
