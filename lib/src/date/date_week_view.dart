import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class DateWeekView extends ViewModelWidget<DateTimePickerViewModel> {
  final BoxConstraints constraints;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;
  final Color? unSelectedTextColor;
  final Color? borderColor;

  const DateWeekView(
    this.constraints, {
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    var w = ((constraints.biggest.width - 20) - (32 * 7)) / 7;
    w = (w + w / 7).roundToDouble() + 0.3;

    return Container(
      height: 58.0 * viewModel.numberOfWeeksToDisplay,
      child: PageView.builder(
        controller: viewModel.dateScrollController,
        itemCount: ((viewModel.dateSlots?.length ?? 0) /
                viewModel.numberOfWeeksToDisplay)
            .round(),
        itemBuilder: (context, index) {
          return ListView.builder(
              itemBuilder: (context, wIndex) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  height: 58,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(width: w);
                    },
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        viewModel.dateSlots![wIndex + index]!.days!.length,
                    itemBuilder: (context, i) {
                      final e = viewModel.dateSlots![wIndex + index]!.days![i];
                      final isSelected = e.index == viewModel.selectedDateIndex;

                      return InkWell(
                        onTap: !e.enabled
                            ? null
                            : () => viewModel.selectedDateIndex = e.index,
                        child: Container(
                          width: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: isSelected
                                ? Border.all(
                                    color: borderColor ??
                                        Theme.of(context).colorScheme.secondary)
                                : null,
                            color: e.enabled
                                ? isSelected
                                    ? (selectedBackgroundColor ??
                                        Theme.of(context).colorScheme.secondary)
                                    : null
                                : Colors.grey.shade300,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('EEE').format(e.date!),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? selectedTextColor ?? Colors.white
                                      : unSelectedTextColor ?? Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${e.date!.day}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? selectedTextColor ?? Colors.white
                                        : unSelectedTextColor ?? Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: viewModel.numberOfWeeksToDisplay);
        },
      ),
    );
  }
}
