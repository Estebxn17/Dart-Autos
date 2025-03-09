import 'package:flutter/material.dart';

class VehicleTile extends StatelessWidget {
  final String vehicleId;
  final String vehicleName;
  final int year;
  final String availability;
  final Function(String) onRent;

  const VehicleTile({
    Key? key,
    required this.vehicleId,
    required this.vehicleName,
    required this.year,
    required this.availability,
    required this.onRent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildStatusIcon(),
        title: Text(
          vehicleName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: _buildVehicleDetails(),
        trailing: _buildActionButton(context),
      ),
    );
  }

  Widget _buildStatusIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: availability == "si"
            ? Colors.green.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.directions_car,
        color: availability == "si" ? Colors.green : Colors.red,
        size: 30,
      ),
    );
  }

  Widget _buildVehicleDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Año: ${year.toString()}',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Disponible: ${availability.toUpperCase()}',
          style: TextStyle(
            color: availability == "si" ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return availability == "si"
        ? IconButton(
            icon: const Icon(Icons.shopping_cart, size: 30),
            color: Colors.blueAccent,
            onPressed: () => _showConfirmationDialog(context),
          )
        : const Text(
            'ALQUILADO',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar operación'),
        content: Text('¿Alquilar $vehicleName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () async {
              Navigator.pop(context);
              try {
                await onRent(vehicleId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Estado actualizado'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
