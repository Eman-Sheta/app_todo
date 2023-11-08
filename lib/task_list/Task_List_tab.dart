import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/provider/app_config_prvider.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';
import 'package:flutter_app_to_do/provider/list_provider.dart';
import 'package:flutter_app_to_do/task_list/task_widget.dart';
import 'package:flutter_app_to_do/theme/my_theme.dart';
import 'package:provider/provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authprovider = Provider.of<AuthProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore(authprovider.currentUser?.id ?? "");
    }
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(children: [
      provider.isDarkMode()
          ? CalendarTimeline(
              initialDate: listProvider.selectDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (data) {
                listProvider.changeData(
                    data, authprovider.currentUser?.id ?? '');
              },
              leftMargin: 20,
              monthColor: MyTheme.whitecolor,
              dayColor: MyTheme.whitecolor,
              activeDayColor: MyTheme.whitecolor,
              activeBackgroundDayColor: Theme.of(context).primaryColor,
              dotsColor: MyTheme.whitecolor,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            )
          : CalendarTimeline(
              initialDate: listProvider.selectDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (data) {
                listProvider.changeData(
                    data, authprovider.currentUser?.id ?? '');
              },
              leftMargin: 20,
              monthColor: MyTheme.blackcolor,
              dayColor: MyTheme.blackcolor,
              activeDayColor: MyTheme.whitecolor,
              activeBackgroundDayColor: Theme.of(context).primaryColor,
              dotsColor: MyTheme.whitecolor,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ),
      Expanded(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return TaskWidget(task: listProvider.tasksList[index]);
          }),
          itemCount: listProvider.tasksList.length,
        ),
      )
    ]);
  }
}
