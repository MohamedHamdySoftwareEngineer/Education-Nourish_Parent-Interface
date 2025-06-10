import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../data/models/bus_model.dart';

class BusInfo extends StatelessWidget {
  const BusInfo({super.key, required this.bus});
  final Bus bus;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: ourMainColor,
          width: 3.0,
        ),
      ),
      child: Column(
        children: [
          // Departure & Arrival information
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.departure_board,
                        color: ourMainColor, size: 28),
                    const SizedBox(height: 8),
                    const Text('Departure time',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF757575))),
                    const SizedBox(height: 4),
                    Text(
                      bus.formattedDepartureTime,
                      style: mainText18,
                    ),
                  ],
                ),
              ),
              Container(height: 70, width: 1, color: const Color(0xFFE0E0E0)),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.access_time_filled,
                        color: ourMainColor, size: 28),
                    const SizedBox(height: 8),
                    const Text('Arrival time',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF757575))),
                    const SizedBox(height: 4),
                    Text(
                      bus.formattedArrivalTime,
                      
                      style: mainText18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(thickness: 1),
          ),
          // Driver & Bus Number information
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.person,
                        color: ourMainColor, size: 28),
                    const SizedBox(height: 8),
                    const Text('Driver name',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF757575))),
                    const SizedBox(height: 4),
                    Text(bus.driverName ?? '',
                        style: mainText18),
                  ],
                ),
              ),
              Container(height: 70, width: 1, color: const Color(0xFFE0E0E0)),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.directions_bus,
                        color: ourMainColor, size: 28),
                    const SizedBox(height: 8),
                    const Text('Bus No.',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF757575))),
                    const SizedBox(height: 4),
                    Text(bus.number ?? '',
                        style: mainText18),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}