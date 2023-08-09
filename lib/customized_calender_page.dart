import 'package:carousel_slider/carousel_slider.dart';
import 'package:customized_calender/customized_calender_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'customized_calender_cubit.dart';

class customizedCalenderPage extends StatefulWidget {
  final customizedCalenderCubit cubit;
  // final UserDetailsInitialParams initialParams;
  const customizedCalenderPage({Key? key, required this.cubit}) : super(key: key);


  @override
  State<customizedCalenderPage> createState() => _customizedCalenderPageState();
}

class _customizedCalenderPageState extends State<customizedCalenderPage> {

  customizedCalenderCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    // TODO : Fix it Later
    cubit.initCalender();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var withOfScreen = MediaQuery.of(context).size.width;

    double boxHeight = withOfScreen / 7;

    return  BlocBuilder(
      bloc:cubit,
          builder:(context,state){
        state as customizedCalenderState;
        return Container(
          child: state.currentWeek!.isEmpty ? SizedBox() : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.onBackClick();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          size: 17,
                          color: theme.primaryColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Back",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    cubit.isCurrentYear()
                        ? DateFormat('MMMM').format(
                      state.currentWeek![0],
                    )
                        : DateFormat('MMMM yyyy').format(
                      state.currentWeek![0],
                    ),
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color:  theme.primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: cubit.isNextDisabled()
                        ? () {
                      cubit.onNextClick();
                    }
                        : null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: cubit.isNextDisabled()
                                ? theme.primaryColor
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                          color: cubit.isNextDisabled()
                              ? theme.primaryColor
                              :  Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              CarouselSlider(
                carouselController: cubit.carouselController,
                items: [
                  if (state.listOfWeeks!.isNotEmpty)
                    for (int ind = 0; ind < state.listOfWeeks!.length; ind++)
                      Container(
                        height: boxHeight,
                        width: withOfScreen,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            for (int weekIndex = 0;
                            weekIndex < state.listOfWeeks![ind].length;
                            weekIndex++)
                              Expanded(
                                child: GestureDetector(
                                  onTap: state.listOfWeeks![ind][weekIndex]
                                      .isBefore(DateTime.now())
                                      ? () {
                                    cubit.onDateSelect(
                                      state.listOfWeeks![ind][weekIndex],
                                    );
                                  }
                                      : null,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: theme.scaffoldBackgroundColor,
                                      ),
                                    ),
                                    child: Column(
                                      // mainAxisAlignment:
                                      // MainAxisAlignment.center,
                                      // crossAxisAlignment:
                                      // CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat(
                                            'E',
                                          ).format(
                                            state.listOfWeeks![ind][weekIndex],
                                          ),
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                            color: Color(0xFF7E7E7E),
                                            // DateFormat('dd-MM-yyyy')
                                            //     .format(listOfWeeks[ind]
                                            // [weekIndex]) ==
                                            //     DateFormat('dd-MM-yyyy')
                                            //         .format(selectedDate)
                                            //     ? widget.activeTextColor ??
                                            //     Colors.black
                                            //     : listOfWeeks[ind][weekIndex]
                                            //     .isBefore(
                                            //     DateTime.now())
                                            //     ? widget.inactiveTextColor ??
                                            //     Colors.black
                                            //         .withOpacity(.2)
                                            //     : widget.disabledTextColor ??
                                            //     Colors.black,
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: DateFormat('dd-MM-yyyy')
                                                  .format(state.listOfWeeks![
                                              ind]
                                              [weekIndex]) ==
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(state.selectedDate as DateTime) ? Colors.blueAccent : Colors.white
                                          ),
                                          child: Center(
                                            child: Text(
                                              // "$weekIndex: ${listOfWeeks[ind][weekIndex] == DateTime.now()}",
                                              "${state.listOfWeeks![ind][weekIndex].day}",
                                              // textAlign: TextAlign.center,

                                              style: TextStyle(fontSize: 12)
                                              !.copyWith(
                                                color: DateFormat('dd-MM-yyyy')
                                                    .format(state.listOfWeeks![
                                                ind]
                                                [weekIndex]) ==
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(state.selectedDate as DateTime)
                                                    ? Colors.white   //TODO : check color here
                                                    : Colors.grey,
                                                // : listOfWeeks[ind][weekIndex]
                                                // .isBefore(
                                                // DateTime.now())
                                                // ? widget.inactiveTextColor ??
                                                // Colors.black.withOpacity(.2) : widget.disabledTextColor ??
                                                // Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                ],
                options: CarouselOptions(
                  scrollPhysics: const ClampingScrollPhysics(),
                  height: boxHeight,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  reverse: true,
                  onPageChanged: (index, reason) {
                    cubit.onWeekChange(index);
                  },
                ),
              ),
            ],
          ),
        );
          } ,
        );
  }

  // @override
  // Widget build(BuildContext context) {
  //   var theme = Theme.of(context);
  //   var withOfScreen = MediaQuery.of(context).size.width;
  //
  //   double boxHeight = withOfScreen / 7;
  //
  //   BlocBuilder(
  //       bloc: cubit,
  //       builder: (context,state){
  //         state as customizedCalenderState;
  //         return currentWeek.isEmpty
  //             ? const SizedBox()
  //             : Column(
  //           children: [
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     onBackClick();
  //                   },
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Icon(
  //                         Icons.arrow_back_ios_new,
  //                         size: 17,
  //                         color:
  //                         widget.activeNavigatorColor ?? theme.primaryColor,
  //                       ),
  //                       const SizedBox(
  //                         width: 4,
  //                       ),
  //                       Text(
  //                         "Back",
  //                         style: theme.textTheme.bodyLarge!.copyWith(
  //                           color: widget.activeNavigatorColor ??
  //                               theme.primaryColor,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Text(
  //                   isCurrentYear()
  //                       ? DateFormat('MMMM').format(
  //                     currentWeek[0],
  //                   )
  //                       : DateFormat('MMMM yyyy').format(
  //                     currentWeek[0],
  //                   ),
  //                   style: theme.textTheme.titleMedium!.copyWith(
  //                     fontWeight: FontWeight.bold,
  //                     color: widget.monthColor ?? theme.primaryColor,
  //                   ),
  //                 ),
  //                 GestureDetector(
  //                   onTap: isNextDisabled()
  //                       ? () {
  //                     onNextClick();
  //                   }
  //                       : null,
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         "Next",
  //                         style: theme.textTheme.bodyLarge!.copyWith(
  //                           color: isNextDisabled()
  //                               ? theme.primaryColor
  //                               : widget.inactiveNavigatorColor ?? Colors.grey,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         width: 4,
  //                       ),
  //                       Icon(
  //                         Icons.arrow_forward_ios,
  //                         size: 17,
  //                         color: isNextDisabled()
  //                             ? theme.primaryColor
  //                             : widget.inactiveNavigatorColor ?? Colors.grey,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(
  //               height: 12,
  //             ),
  //             CarouselSlider(
  //               carouselController: carouselController,
  //               items: [
  //                 if (listOfWeeks.isNotEmpty)
  //                   for (int ind = 0; ind < listOfWeeks.length; ind++)
  //                     Container(
  //                       height: boxHeight,
  //                       width: withOfScreen,
  //                       color: Colors.transparent,
  //                       child: Row(
  //                         children: [
  //                           for (int weekIndex = 0;
  //                           weekIndex < listOfWeeks[ind].length;
  //                           weekIndex++)
  //                             Expanded(
  //                               child: GestureDetector(
  //                                 onTap: listOfWeeks[ind][weekIndex]
  //                                     .isBefore(DateTime.now())
  //                                     ? () {
  //                                   onDateSelect(
  //                                     listOfWeeks[ind][weekIndex],
  //                                   );
  //                                 }
  //                                     : null,
  //                                 child: Container(
  //                                   alignment: Alignment.center,
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.white,
  //                                     border: Border.all(
  //                                       color: theme.scaffoldBackgroundColor,
  //                                     ),
  //                                   ),
  //                                   child: Column(
  //                                     // mainAxisAlignment:
  //                                     // MainAxisAlignment.center,
  //                                     // crossAxisAlignment:
  //                                     // CrossAxisAlignment.center,
  //                                     children: [
  //                                       Text(
  //                                         DateFormat(
  //                                           'E',
  //                                         ).format(
  //                                           listOfWeeks[ind][weekIndex],
  //                                         ),
  //                                         textAlign: TextAlign.center,
  //                                         style: theme.textTheme.bodyLarge!
  //                                             .copyWith(
  //                                           color: Color(0xFF7E7E7E),
  //                                           // DateFormat('dd-MM-yyyy')
  //                                           //     .format(listOfWeeks[ind]
  //                                           // [weekIndex]) ==
  //                                           //     DateFormat('dd-MM-yyyy')
  //                                           //         .format(selectedDate)
  //                                           //     ? widget.activeTextColor ??
  //                                           //     Colors.black
  //                                           //     : listOfWeeks[ind][weekIndex]
  //                                           //     .isBefore(
  //                                           //     DateTime.now())
  //                                           //     ? widget.inactiveTextColor ??
  //                                           //     Colors.black
  //                                           //         .withOpacity(.2)
  //                                           //     : widget.disabledTextColor ??
  //                                           //     Colors.black,
  //                                         ),
  //                                       ),
  //                                       Container(
  //                                         height: 25,
  //                                         width: 25,
  //                                         decoration: BoxDecoration(
  //                                             shape: BoxShape.circle,
  //                                             color: DateFormat('dd-MM-yyyy')
  //                                                 .format(listOfWeeks[
  //                                             ind]
  //                                             [weekIndex]) ==
  //                                                 DateFormat('dd-MM-yyyy')
  //                                                     .format(selectedDate) ? Colors.blueAccent : Colors.white
  //                                         ),
  //                                         child: Center(
  //                                           child: Text(
  //                                             // "$weekIndex: ${listOfWeeks[ind][weekIndex] == DateTime.now()}",
  //                                             "${listOfWeeks[ind][weekIndex].day}",
  //                                             // textAlign: TextAlign.center,
  //
  //                                             style: TextStyle(fontSize: 12)
  //                                             !.copyWith(
  //                                               color: DateFormat('dd-MM-yyyy')
  //                                                   .format(listOfWeeks[
  //                                               ind]
  //                                               [weekIndex]) ==
  //                                                   DateFormat('dd-MM-yyyy')
  //                                                       .format(selectedDate)
  //                                                   ? Colors.white   //TODO : check color here
  //                                                   : widget.inactiveTextColor,
  //                                               // : listOfWeeks[ind][weekIndex]
  //                                               // .isBefore(
  //                                               // DateTime.now())
  //                                               // ? widget.inactiveTextColor ??
  //                                               // Colors.black.withOpacity(.2) : widget.disabledTextColor ??
  //                                               // Colors.black,
  //                                               fontWeight: FontWeight.bold,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       const SizedBox(
  //                                         height: 4,
  //                                       ),
  //
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                         ],
  //                       ),
  //                     ),
  //               ],
  //               options: CarouselOptions(
  //                 scrollPhysics: const ClampingScrollPhysics(),
  //                 height: boxHeight,
  //                 viewportFraction: 1,
  //                 enableInfiniteScroll: false,
  //                 reverse: true,
  //                 onPageChanged: (index, reason) {
  //                   onWeekChange(index);
  //                 },
  //               ),
  //             ),
  //           ],
  //         );
  //       } ),
  //
  //   return currentWeek.isEmpty
  //       ? const SizedBox()
  //       : Column(
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           GestureDetector(
  //             onTap: () {
  //               onBackClick();
  //             },
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.arrow_back_ios_new,
  //                   size: 17,
  //                   color:
  //                   widget.activeNavigatorColor ?? theme.primaryColor,
  //                 ),
  //                 const SizedBox(
  //                   width: 4,
  //                 ),
  //                 Text(
  //                   "Back",
  //                   style: theme.textTheme.bodyLarge!.copyWith(
  //                     color: widget.activeNavigatorColor ??
  //                         theme.primaryColor,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Text(
  //             isCurrentYear()
  //                 ? DateFormat('MMMM').format(
  //               currentWeek[0],
  //             )
  //                 : DateFormat('MMMM yyyy').format(
  //               currentWeek[0],
  //             ),
  //             style: theme.textTheme.titleMedium!.copyWith(
  //               fontWeight: FontWeight.bold,
  //               color: widget.monthColor ?? theme.primaryColor,
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: isNextDisabled()
  //                 ? () {
  //               onNextClick();
  //             }
  //                 : null,
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   "Next",
  //                   style: theme.textTheme.bodyLarge!.copyWith(
  //                     color: isNextDisabled()
  //                         ? theme.primaryColor
  //                         : widget.inactiveNavigatorColor ?? Colors.grey,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 4,
  //                 ),
  //                 Icon(
  //                   Icons.arrow_forward_ios,
  //                   size: 17,
  //                   color: isNextDisabled()
  //                       ? theme.primaryColor
  //                       : widget.inactiveNavigatorColor ?? Colors.grey,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: 12,
  //       ),
  //       CarouselSlider(
  //         carouselController: carouselController,
  //         items: [
  //           if (listOfWeeks.isNotEmpty)
  //             for (int ind = 0; ind < listOfWeeks.length; ind++)
  //               Container(
  //                 height: boxHeight,
  //                 width: withOfScreen,
  //                 color: Colors.transparent,
  //                 child: Row(
  //                   children: [
  //                     for (int weekIndex = 0;
  //                     weekIndex < listOfWeeks[ind].length;
  //                     weekIndex++)
  //                       Expanded(
  //                         child: GestureDetector(
  //                           onTap: listOfWeeks[ind][weekIndex]
  //                               .isBefore(DateTime.now())
  //                               ? () {
  //                             onDateSelect(
  //                               listOfWeeks[ind][weekIndex],
  //                             );
  //                           }
  //                               : null,
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               border: Border.all(
  //                                 color: theme.scaffoldBackgroundColor,
  //                               ),
  //                             ),
  //                             child: Column(
  //                               // mainAxisAlignment:
  //                               // MainAxisAlignment.center,
  //                               // crossAxisAlignment:
  //                               // CrossAxisAlignment.center,
  //                               children: [
  //                                 Text(
  //                                   DateFormat(
  //                                     'E',
  //                                   ).format(
  //                                     listOfWeeks[ind][weekIndex],
  //                                   ),
  //                                   textAlign: TextAlign.center,
  //                                   style: theme.textTheme.bodyLarge!
  //                                       .copyWith(
  //                                     color: Color(0xFF7E7E7E),
  //                                     // DateFormat('dd-MM-yyyy')
  //                                     //     .format(listOfWeeks[ind]
  //                                     // [weekIndex]) ==
  //                                     //     DateFormat('dd-MM-yyyy')
  //                                     //         .format(selectedDate)
  //                                     //     ? widget.activeTextColor ??
  //                                     //     Colors.black
  //                                     //     : listOfWeeks[ind][weekIndex]
  //                                     //     .isBefore(
  //                                     //     DateTime.now())
  //                                     //     ? widget.inactiveTextColor ??
  //                                     //     Colors.black
  //                                     //         .withOpacity(.2)
  //                                     //     : widget.disabledTextColor ??
  //                                     //     Colors.black,
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                   height: 25,
  //                                   width: 25,
  //                                   decoration: BoxDecoration(
  //                                       shape: BoxShape.circle,
  //                                       color: DateFormat('dd-MM-yyyy')
  //                                           .format(listOfWeeks[
  //                                       ind]
  //                                       [weekIndex]) ==
  //                                           DateFormat('dd-MM-yyyy')
  //                                               .format(selectedDate) ? Colors.blueAccent : Colors.white
  //                                   ),
  //                                   child: Center(
  //                                     child: Text(
  //                                       // "$weekIndex: ${listOfWeeks[ind][weekIndex] == DateTime.now()}",
  //                                       "${listOfWeeks[ind][weekIndex].day}",
  //                                       // textAlign: TextAlign.center,
  //
  //                                       style: TextStyle(fontSize: 12)
  //                                       !.copyWith(
  //                                         color: DateFormat('dd-MM-yyyy')
  //                                             .format(listOfWeeks[
  //                                         ind]
  //                                         [weekIndex]) ==
  //                                             DateFormat('dd-MM-yyyy')
  //                                                 .format(selectedDate)
  //                                             ? Colors.white   //TODO : check color here
  //                                             : widget.inactiveTextColor,
  //                                         // : listOfWeeks[ind][weekIndex]
  //                                         // .isBefore(
  //                                         // DateTime.now())
  //                                         // ? widget.inactiveTextColor ??
  //                                         // Colors.black.withOpacity(.2) : widget.disabledTextColor ??
  //                                         // Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 4,
  //                                 ),
  //
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                   ],
  //                 ),
  //               ),
  //         ],
  //         options: CarouselOptions(
  //           scrollPhysics: const ClampingScrollPhysics(),
  //           height: boxHeight,
  //           viewportFraction: 1,
  //           enableInfiniteScroll: false,
  //           reverse: true,
  //           onPageChanged: (index, reason) {
  //             onWeekChange(index);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

}
