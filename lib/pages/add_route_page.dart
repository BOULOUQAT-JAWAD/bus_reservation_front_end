import 'package:bus_reservation_front_end/models/bus_route.dart';
import 'package:bus_reservation_front_end/providers/app_data_provider.dart';
import 'package:bus_reservation_front_end/utils/constants.dart';
import 'package:bus_reservation_front_end/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({super.key});

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  final _formKey = GlobalKey<FormState>();
  String? from, to;
  final distanecController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Route'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            shrinkWrap: true,
            children: [
              DropdownButtonFormField<String>(
                onChanged: (value) {
                  from = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Select a city';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.white70)),
                items: cities
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                value: from,
                hint: const Text('From'),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<String>(
                onChanged: (value) {
                  to = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Select a city';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.white70)),
                items: cities
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                value: to,
                hint: const Text('To'),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: distanecController,
                decoration: const InputDecoration(
                    hintText: 'Distance in Kilometer',
                    filled: true,
                    prefixIcon: Icon(Icons.social_distance_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: addRoute,
                    child: const Text('ADD Route'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addRoute() {
    if (_formKey.currentState!.validate()) {
      final route = BusRoute(
          routeName: '$from-$to',
          cityFrom: from!,
          cityTo: to!,
          distanceInKm: double.parse(distanecController.text));
      Provider.of<AppDataProvider>(context, listen: false)
          .addRoute(route)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMsg(context, response.message);
          resetFields();
        }
      });
    }
  }

  void resetFields() {
    distanecController.clear();
  }

  @override
  void dispose() {
    distanecController.clear();
    super.dispose();
  }
}
