import 'package:flutter/material.dart';
import 'customized_calender_initial_params.dart';

enum WeekStartFrom {
  Sunday,
  Monday,
}



class customizedCalenderState {

  /// week start from [WeekStartFrom.Monday]
  final WeekStartFrom? weekStartFrom;

  ///get DateTime on date select
  final Function(DateTime)? onDateChange;

  ///get the list of DateTime on week change
  final Function(List<DateTime>)? onWeekChange;

  /// Active background color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeBackgroundColor;

  /// In-Active background color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? inactiveBackgroundColor;

  /// Disable background color
  ///
  /// Default value [Colors.grey]
  final Color? disabledBackgroundColor;

  /// Active text color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeTextColor;

  /// In-Active text color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? inactiveTextColor;

  /// Disable text color
  ///
  /// Default value [Colors.grey]
  final Color? disabledTextColor;

  /// Active Navigator color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeNavigatorColor;

  /// In-Active Navigator color
  ///
  /// Default value [Colors.grey]
  final Color? inactiveNavigatorColor;

  /// Month Color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? monthColor;
  // final DateTime? selectedDate;
  //final  currentWeek;
  DateTime? today;
  DateTime? selectedDate;
  List<DateTime>? currentWeek;
  int? currentWeekIndex;
  List<List<DateTime>>? listOfWeeks;



  // var currentWeek;
  customizedCalenderState({
    this.onDateChange,
    this.onWeekChange,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
    this.disabledBackgroundColor,
    this.activeTextColor = Colors.black,
    this.inactiveTextColor,
    this.disabledTextColor,
    this.activeNavigatorColor,
    this.inactiveNavigatorColor,
    this.monthColor,
    this.weekStartFrom = WeekStartFrom.Monday,
    this.selectedDate,
    this.today,
    this.currentWeek,
    this.currentWeekIndex,
    this.listOfWeeks
    });

  factory customizedCalenderState.initial({required customizedCalenderInitialParams initialParams}) =>
      customizedCalenderState(
        selectedDate: DateTime.now(),
          today: DateTime.now(),
          currentWeek:[],
          currentWeekIndex:0,
          listOfWeeks:[],
  );

  customizedCalenderState copyWith({
    DateTime? selectedDate,
    DateTime? today,
    List<DateTime>? currentWeek,
    int? currentWeekIndex,
    List<List<DateTime>>? listOfWeeks
    }) =>
      customizedCalenderState(
        selectedDate: selectedDate ?? this.selectedDate,
        today: today ?? this.today,
        currentWeek: currentWeek ?? this.currentWeek,
        currentWeekIndex: currentWeekIndex ?? this.currentWeekIndex,
        listOfWeeks: listOfWeeks ?? this.listOfWeeks
      );
}