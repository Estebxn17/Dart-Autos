import 'package:flutter/material.dart';
import 'details.dart';

class VehicleTile extends StatelessWidget {
  final String vehicleName;
  final int year;
  final String availability;

  const VehicleTile({
    Key? key,
    required this.vehicleName,
    required this.year,
    required this.availability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.directions_car, color: Colors.redAccent),
      title: Text(vehicleName),
      subtitle: Text('Año: $year - Disponibilidad: $availability'),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleDetailScreen(
              vehicleName: vehicleName,
              year: year,
              availability: availability,
            ),
          ),
        );
     },
);
}
}