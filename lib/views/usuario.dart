
import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Foto de perfil
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              
              
              Text(
                'Nombre de Usuario',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'correo@ejemplo.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24),
              
              
              ListTile(
                leading: Icon(Icons.badge),
                title: Text('Número de licencia'),
                subtitle: Text('123456789'),
              ),
              Divider(),

              
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Cambiar contraseña'),
                onTap: () {
                  
                },
              ),
              Divider(),

              
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Revisar Alquileres'),
                onTap: () {
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
