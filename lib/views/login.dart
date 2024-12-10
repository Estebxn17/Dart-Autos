import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_autos/views/register.dart';
import 'package:flutter_autos/views/gestion.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://localhost:5000/api/personas/login'); // Cambia a tu URL
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'correo': _emailController.text.trim(),
            'contraseña': _passwordController.text.trim(),
          }),
        );

        if (response.statusCode == 200) {
          // Inicio de sesión exitoso
          final responseData = jsonDecode(response.body);
          print('Inicio de sesión exitoso: ${responseData['message']}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => VehicleRentalScreen()),
          );
        } else {
          // Error al iniciar sesión
          final responseData = jsonDecode(response.body);
          _showErrorDialog(context, responseData['error'] ?? 'Error desconocido');
        }
      } catch (e) {
        _showErrorDialog(context, 'No se pudo conectar con el servidor. Inténtalo de nuevo.');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.redAccent)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 80, color: Colors.redAccent),
                  SizedBox(height: 20),
                  Text(
                    'Bienvenido',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Por favor ingrese su correo';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Ingrese un correo válido';
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Por favor ingrese su contraseña';
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () => _login(context),
                    child: Text('Iniciar sesión', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿No tienes una cuenta? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          'Regístrate',
                          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
