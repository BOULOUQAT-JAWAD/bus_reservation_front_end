import 'dart:developer';

import 'package:bus_reservation_front_end/customwidgets/reservation_item_body.dart';
import 'package:bus_reservation_front_end/customwidgets/reservation_item_header.dart';
import 'package:bus_reservation_front_end/customwidgets/search_box.dart';
import 'package:bus_reservation_front_end/models/reservation_expansion_item.dart';
import 'package:bus_reservation_front_end/providers/app_data_provider.dart';
import 'package:bus_reservation_front_end/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  bool isFirst = true;
  List<ReservationExpansionItem> items = [];

  @override
  void didChangeDependencies() {
    if (isFirst) {
      _getData();
    }
    isFirst = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(onSubmit: (value) {
              _search(value);
            }),
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  items[panelIndex].isExpanded = isExpanded;
                });
              },
              children: items
                  .map((item) => ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) =>
                          ReservationItemHeaderView(header: item.header),
                      body: ReservationItemBodyView(body: item.body)))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  void _getData() async {
    final reservation =
        await Provider.of<AppDataProvider>(context, listen: false)
            .getAllReservations();
    items = Provider.of<AppDataProvider>(context, listen: false)
        .getExpansionItems(reservation);
    setState(() {});
  }

  void _search(String value) async {
    final data = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationsByMobile(value);
    if (data.isEmpty) {
      showMsg(context, 'No record found');
      return;
    }
    setState(() {
      items = Provider.of<AppDataProvider>(context, listen: false)
          .getExpansionItems(data);
    });
  }
}
