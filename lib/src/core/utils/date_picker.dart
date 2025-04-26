import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerHelper {
  static Future<DateTime?> showDatePickerDialog(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    Color? selectionColor,
    TextStyle? selectionTextStyle,
    Color? backgroundColor,
  }) async {
    DateTime? selectedDate;

    await showDialog<void>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Modern rounded corners
          ),
          contentPadding: const EdgeInsets.all(16),
          content: SizedBox(
            width: 350,
            height: 400,
            child: SfDateRangePicker(
              backgroundColor: backgroundColor ??
                  Theme.of(context).scaffoldBackgroundColor, // Set background color
              selectionRadius: 12,
              showActionButtons: true,
              onCancel: () {
                context.pop();
              },
              onSubmit: (args) {
                if (args is DateTime) {
                  selectedDate = args;
                  Navigator.pop(context);
                }
              },
              initialSelectedDate: initialDate ?? DateTime.now(),
              minDate: minDate ?? DateTime(1950),
              maxDate: maxDate ?? DateTime.now(),
              onSelectionChanged: (args) {
                if (args.value is DateTime) {
                  selectedDate = args.value as DateTime;
                  Navigator.pop(context);
                }
              },

              // Theme-aware styling
              headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: theme.colorScheme.surface, // Matches dialog background
                textStyle: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface, // Contrast text color
                ),
                textAlign: TextAlign.center,
              ),
              selectionColor:
                  selectionColor ?? theme.colorScheme.primary, // Theme-based color
              selectionTextStyle: selectionTextStyle ??
                  TextStyle(
                    color: theme.colorScheme.onPrimary, // Contrast text for selection
                    fontWeight: FontWeight.bold,
                  ),
              todayHighlightColor:
                  theme.colorScheme.secondary.withOpacity(0.2), // Add today indicator
            ),
          ),
        );
      },
    );

    return selectedDate;
  }
}


// -------------------------

// SfDateRangePicker({
//   Key? key, // Standard Flutter widget key [[1]]
  
//   DateRangePickerView view = DateRangePickerView.month, // Initial display view (month/year) [[1]]
  
//   this.selectionMode = DateRangePickerSelectionMode.single, // Selection type (single/multiple/range) [[1]]
  
//   this.headerHeight = 40, // Height of the header section [[1]]
  
//   this.todayHighlightColor, // Color for highlighting today's date [[1]]
  
//   this.backgroundColor, // Background color of the picker [[1]]
  
//   DateTime? initialSelectedDate, // Initially selected date [[1]]
  
//   List<DateTime>? initialSelectedDates, // List of initially selected dates [[1]]
  
//   PickerDateRange? initialSelectedRange, // Initial date range selection [[1]]
  
//   List<PickerDateRange>? initialSelectedRanges, // List of initial ranges [[1]]
  
//   this.toggleDaySelection = false, // Allow toggling selection of already selected dates [[1]]
  
//   this.enablePastDates = true, // Enable/disable past dates [[1]]
  
//   this.showNavigationArrow = false, // Show left/right navigation arrows [[1]]
  
//   this.confirmText = 'OK', // Text for confirm button [[1]]
  
//   this.cancelText = 'CANCEL', // Text for cancel button [[1]]
  
//   this.showActionButtons = false, // Show action buttons (OK/Cancel) [[1]]
  
//   this.selectionShape = DateRangePickerSelectionShape.circle, // Selection shape (circle/rectangle) [[1]]
  
//   this.navigationDirection = DateRangePickerNavigationDirection.horizontal, // Scroll direction (horizontal/vertical) [[1]]
  
//   this.allowViewNavigation = true, // Allow view switching (month<->year) [[1]]
  
//   this.navigationMode = DateRangePickerNavigationMode.snap, // Scroll behavior (snap/continuous) [[1]]
  
//   this.enableMultiView = false, // Show multiple views side-by-side [[1]]
  
//   this.controller, // Controller for programmatic control [[1]]
  
//   this.onViewChanged, // Callback when view changes (swipe/switch) [[2],[3],[9]]
  
//   this.onSelectionChanged, // Callback when date selection changes [[1]]
  
//   this.onCancel, // Callback when cancel button pressed [[1]]
  
//   this.onSubmit, // Callback when confirm button pressed [[1]]
  
//   this.headerStyle = const DateRangePickerHeaderStyle(), // Header styling [[1]]
  
//   this.yearCellStyle = const DateRangePickerYearCellStyle(), // Year view styling [[1]]
  
//   this.monthViewSettings = const DateRangePickerMonthViewSettings(), // Month view configuration [[1]]
  
//   this.monthCellStyle = const DateRangePickerMonthCellStyle(), // Month cell styling [[1]]
  
//   DateTime? minDate, // Minimum selectable date [[1]]
  
//   DateTime? maxDate, // Maximum selectable date [[1]]
  
//   DateTime? initialDisplayDate, // Initial displayed date [[1]]
  
//   double viewSpacing = 20, // Spacing between multi-views [[1]]
  
//   this.selectionRadius = -1, // Selection indicator radius (auto if -1) [[1]]
  
//   this.selectionColor, // Color of selected dates [[1]]
  
//   this.startRangeSelectionColor, // Start color for range selections [[1]]
  
//   this.endRangeSelectionColor, // End color for range selections [[1]]
  
//   this.rangeSelectionColor, // Color for range middle dates [[1]]
  
//   this.selectionTextStyle, // Text style for selected dates [[1]]
  
//   this.rangeTextStyle, // Text style for range selection endpoints [[1]]
  
//   this.monthFormat, // Custom month display format (e.g., "MMM yyyy") [[1]]
  
//   this.cellBuilder, // Custom cell widget builder [[1]]
  
//   this.showTodayButton = false, // Show "Today" button [[1]]
  
//   this.selectableDayPredicate, // Date selection validation callback [[1]]
  
//   this.extendableRangeSelectionDirection = ExtendableRangeSelectionDirection.both // Range selection direction options [[1]]
// });