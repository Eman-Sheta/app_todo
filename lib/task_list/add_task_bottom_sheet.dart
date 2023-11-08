import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/Model/task.dart';
import 'package:flutter_app_to_do/auth/Dialog_utils.dart';
import 'package:flutter_app_to_do/firebase_utils.dart';
import 'package:flutter_app_to_do/provider/app_config_prvider.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';
import 'package:flutter_app_to_do/provider/list_provider.dart';
import 'package:flutter_app_to_do/theme/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return provider.isDarkMode()
        ? Container(
            color: MyTheme.primarydark,
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Text(
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MyTheme.whitecolor),
              ),
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter task title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.enter_task_title,
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .enter_task_description,
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.select_data,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyTheme.whitecolor),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.whitecolor),
                        ))
                  ],
                ),
              )
            ]),
          )
        : Container(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Text(
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter task title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.enter_task_title,
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .enter_task_description,
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.select_data,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: Theme.of(context).textTheme.titleLarge,
                        ))
                  ],
                ),
              )
            ]),
          );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(
          days: 365,
        )));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formkey.currentState?.validate() == true) {
      // added task
      // todo show loading
      DialogUtils.showLoading(context, 'loading...');
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      var authprovider = Provider.of<AuthProvider>(context, listen: false);
      FirebaseUtils.addTaskFireStore(task, authprovider.currentUser!.id!)
          .then((value) {
        // todo hide loading
        DialogUtils.hideLoading(context);
        // todo show message
        DialogUtils.showMessage(context, 'Todo succuessfully',
            posActionName: 'ok');
        print('todo added succuessfully');
        listProvider.getAllTasksFromFireStore(authprovider.currentUser!.id!);
        Navigator.pop(context);
      }).timeout(Duration(microseconds: 500), onTimeout: () {
        print('todo added succuessfully');
        listProvider.getAllTasksFromFireStore(authprovider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}
