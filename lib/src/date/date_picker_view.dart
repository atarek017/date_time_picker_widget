import 'package:date_time_picker_widget/src/date/date_week_view.dart';
import 'package:date_time_picker_widget/src/date/date_weekdays_view.dart';
import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class DatePickerView extends ViewModelWidget<DateTimePickerViewModel> {
  final BoxConstraints constraints;
  final String? locale;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;
  final Color? unSelectedTextColor;
  final Color? borderColor;
  final Color? monYearSwitcherTextColor;
  final Color? monYearSwitcherIconColor;

  const DatePickerView({
    super.key,
    required this.constraints,
    this.locale,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.borderColor,
    this.monYearSwitcherTextColor,
    this.monYearSwitcherIconColor,
  });

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    initializeDateFormatting(locale);

    return Column(
      children: [
        MonYearSwitcher(locale: locale),
        DateWeekView(
          constraints,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
          unSelectedTextColor: unSelectedTextColor,
          borderColor: borderColor,
        ),
      ],
    );
  }
}

class MonYearSwitcher extends ViewModelWidget<DateTimePickerViewModel> {
  final String? locale;
  final Color? monYearSwitcherTextColor;
  final Color? monYearSwitcherIconColor;

  const MonYearSwitcher({
    super.key,
    this.locale,
    this.monYearSwitcherTextColor,
    this.monYearSwitcherIconColor,
  });

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: monYearSwitcherIconColor ?? Colors.black,
              ),
              onPressed: viewModel.onClickPrevious),
          Text(
            viewModel.selectedDate != null
                ? '${DateFormat('MMMM yyyy', locale).format(viewModel.selectedDate!)}'
                : '',
            style: TextStyle(
              fontSize: 18,
              color: monYearSwitcherTextColor ?? Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          IconButton(
              icon: Icon(
                Icons.navigate_next,
                color: monYearSwitcherIconColor ?? Colors.black,
              ),
              onPressed: viewModel.onClickNext),
        ],
      ),
    );
  }
}
