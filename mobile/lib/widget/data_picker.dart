import 'package:flutter/material.dart';
import 'package:mobile/utils/helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerModal extends StatefulWidget {
  const DatePickerModal({Key? key}) : super(key: key);

  @override
  _DatePickerModalState createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(_selectedDate),
                  child: Text('OK'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  _selectedDate = args.value.startDate!;
                });
              },
              enableMultiView: true,
              initialSelectedDate: _selectedDate,
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ),
        ],
      ),
    );
  }
}
