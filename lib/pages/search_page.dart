import 'package:bus_reservation_front_end/drawers/main_drawer.dart';
import 'package:bus_reservation_front_end/providers/app_data_provider.dart';
import 'package:bus_reservation_front_end/utils/constants.dart';
import 'package:bus_reservation_front_end/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: [
              DropdownButtonFormField<String>(
                  value: fromCity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    // means that everything is fine
                    return null;
                  },
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                  ),
                  hint: const Text('From'),
                  isExpanded: true,
                  items: cities
                      .map((city) => DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          ))
                      .toList(),
                  onChanged: (value) {
                    fromCity = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                  value: toCity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return emptyFieldErrMessage;
                    }
                    // means that everything is fine
                    return null;
                  },
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                  ),
                  hint: const Text('To'),
                  isExpanded: true,
                  items: cities
                      .map((city) => DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          ))
                      .toList(),
                  onChanged: (value) {
                    toCity = value;
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: _selectDate,
                        child: const Text('Select Departure Date')),
                    Text(departureDate == null
                        ? 'No day choosen'
                        : getFormattedDate(departureDate!,
                            pattern: 'EEE MMM dd, yyyy')),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _search,
                    child: const Text('SEARCH'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7)));
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      showMsg(context, emptyDateErrMessage);
      return;
    }

    if (_formKey.currentState!.validate()) {
      //we set listen to false, to tell that we don't want the wedget to be rebuild
      Provider.of<AppDataProvider>(context, listen: false)
          .getRouteByCityFromAndCityTo(fromCity!, toCity!)
          .then((route) {
        Navigator.pushNamed(context, routeNameSearchResultPage,
            arguments: [route, getFormattedDate(departureDate!)]);
      });
      //showMsg(context, route.routeName);
      //showMsg(context, 'No route Found');
    }
  }
  /*
  void _search() {
  if (departureDate == null) {
    showMsg(context, emptyDateErrMessage);
    return;
  }

  if (_formKey.currentState!.validate()) {
    //we set listen to false, to tell that we don't want the widget to be rebuilt
    Provider.of<AppDataProvider>(context, listen: false)
        .getRouteByCityFromAndCityTo(fromCity!, toCity!)
        .then((route) {
      if (route != null) {
        Navigator.pushNamed(context, routeNameSearchResultPage,
            arguments: [route, getFormattedDate(departureDate!)]);
      } else {
        showMsg(context, 'No route found.');
      }
    }).catchError((error) {
      showMsg(context, 'An error occurred while searching for the route.');
      print('Error: $error');
    });
  }
}

  */
}
