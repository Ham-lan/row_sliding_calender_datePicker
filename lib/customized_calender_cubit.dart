import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'customized_calender_initial_params.dart';
import 'customized_calender_state.dart';

class customizedCalenderCubit extends Cubit<customizedCalenderState> {
 final customizedCalenderInitialParams initialParams;
 CarouselController? carouselController = CarouselController();

 customizedCalenderCubit(this.initialParams) : super(customizedCalenderState.initial(initialParams: initialParams));

  void onInit(customizedCalenderInitialParams initialParams) {
   emit(state.copyWith());
  }

 DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

 initCalender() {
  // List<DateTime> minus3Days = [];
  // List<DateTime> add3Days = [];
  // for (int index = 0; index < 3; index++) {
  //   DateTime minusDate = today.add(Duration(days: -(index + 1)));
  //   minus3Days.add(minusDate);
  //   DateTime addDate = today.add(Duration(days: (index + 1)));
  //   add3Days.add(addDate);
  // }
  // currentWeek.addAll(minus3Days.reversed.toList());
  // currentWeek.add(today);
  // currentWeek.addAll(add3Days);
  // listOfWeeks.add(currentWeek);

  final date = DateTime.now();

  DateTime startOfCurrentWeek = state.weekStartFrom == WeekStartFrom.Monday
      ? getDate(date.subtract(Duration(days: date.weekday - 1)))
      : getDate(date.subtract(Duration(days: date.weekday % 7)));

  state.currentWeek!.add(startOfCurrentWeek);
  for (int index = 0; index < 6; index++) {
   DateTime addDate = startOfCurrentWeek.add(Duration(days: (index + 1)));
   state.currentWeek!.add(addDate);
  }

  state.listOfWeeks?.add(state.currentWeek ?? []);
  emit(state.copyWith());
  getMorePreviousWeeks();
 }

 getMorePreviousWeeks() {
  List<DateTime> minus7Days = [];
  DateTime startFrom = state.listOfWeeks!.isEmpty
      ? DateTime.now()
      : state.listOfWeeks![state.currentWeekIndex ?? 0].isEmpty
      ? DateTime.now()
      : state.listOfWeeks![state.currentWeekIndex?? 0][0];

  for (int index = 0; index < 7; index++) {
   DateTime minusDate = startFrom.add(Duration(days: -(index + 1)));
   minus7Days.add(minusDate);
  }
  state.listOfWeeks?.add(minus7Days.reversed.toList());
  emit(state.copyWith());
 }

 onDateSelect(DateTime date) {
  state.onDateChange?.call(date);
  emit(state.copyWith(selectedDate: date));
 }

 onBackClick() {
  carouselController?.nextPage();
  emit(state.copyWith());
 }

 onNextClick() {
  carouselController!.previousPage();
  emit(state.copyWith());
 }

 onWeekChange(index) {
  state.currentWeekIndex = index;
  state.currentWeek = state.listOfWeeks?[state.currentWeekIndex ?? 0];

  if (state.currentWeekIndex! + 1 == (state.listOfWeeks)?.length) {
   getMorePreviousWeeks();
  }

  state.onWeekChange?.call(state.currentWeek ?? []);
  emit(state.copyWith());
 }

 // =================

 isNextDisabled() {
  return state.listOfWeeks?[state.currentWeekIndex ?? 0].last.isBefore(DateTime.now());
  emit(state.copyWith());
 }

 isCurrentYear() {
  return DateFormat('yyyy').format(state.currentWeek![0]) ==
      DateFormat('yyyy').format(state.today ?? DateTime.now());
 }


}