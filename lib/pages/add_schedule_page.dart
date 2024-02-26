import 'package:bus_reservation_front_end/datasource/temp_db.dart';
import 'package:bus_reservation_front_end/models/bus_model.dart';
import 'package:bus_reservation_front_end/models/bus_route.dart';
import 'package:bus_reservation_front_end/models/bus_schedule.dart';
import 'package:bus_reservation_front_end/providers/app_data_provider.dart';
import 'package:bus_reservation_front_end/utils/constants.dart';
import 'package:bus_reservation_front_end/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  Bus? bus;
  BusRoute? busRoute;
  TimeOfDay? timeOfDay;
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final feeController = TextEditingController();

  @override
  void didChangeDependencies() {
    _getData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Schedule'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            //he widget will adjust its size to fit the children's size along the main axis
            shrinkWrap: true,
            children: [
              Consumer<AppDataProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonFormField<Bus>(
                  onChanged: (value) {
                    setState(() {
                      bus = value;
                    });
                  },
                  //it will cause the dropdown menu to expand to fill the available vertical space
                  isExpanded: true,
                  value: bus,
                  hint: const Text('Select Bus'),
                  items: provider.busList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text('${e.busName}-${e.busType}'),
                        ),
                      )
                      .toList(),
                ),
              ),
              Consumer<AppDataProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonFormField<BusRoute>(
                  onChanged: (value) {
                    setState(() {
                      busRoute = value;
                    });
                  },
                  //it will cause the dropdown menu to expand to fill the available vertical space
                  isExpanded: true,
                  value: busRoute,
                  hint: const Text('Select Route'),
                  items: provider.routeList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.routeName),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: 'Ticket Price',
                  filled: true,
                  prefixIcon: Icon(Icons.price_change),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: discountController,
                decoration: const InputDecoration(
                  hintText: 'Discount(%)',
                  filled: true,
                  prefixIcon: Icon(Icons.discount),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: feeController,
                decoration: const InputDecoration(
                  hintText: 'Processing Fee',
                  filled: true,
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _selectTime,
                    child: const Text('Select Departure Time'),
                  ),
                  Text(timeOfDay == null
                      ? 'No Time chosen'
                      : getFormattedTime(timeOfDay!))
                ],
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: addSchedule,
                    child: const Text('ADD Schedule'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getData() {
    Provider.of<AppDataProvider>(context, listen: false).getAllBus();
    Provider.of<AppDataProvider>(context, listen: false).getAllBusRoutes();
  }

  void addSchedule() {
    if (timeOfDay == null) {
      showMsg(context, 'Please select a departure date');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final busSchedule = BusSchedule(
        scheduleId: TempDB.tableSchedule.length + 1,
        bus: bus!,
        busRoute: busRoute!,
        departureTime: getFormattedTime(timeOfDay!),
        ticketPrice: int.parse(priceController.text),
        discount: int.parse(discountController.text),
        processingFee: int.parse(feeController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addSchedule(busSchedule)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMsg(context, response.message);
          resetFields();
        }
      });
    }
  }

  void resetFields() {
    priceController.clear();
    discountController.clear();
    feeController.clear();
  }

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    feeController.dispose();
    super.dispose();
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time != null) {
      setState(() {
        timeOfDay = time;
      });
    }
  }
}
