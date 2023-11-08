import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/Model/task.dart';
import 'package:flutter_app_to_do/auth/Dialog_utils.dart';
import 'package:flutter_app_to_do/firebase_utils.dart';
import 'package:flutter_app_to_do/provider/app_config_prvider.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';
import 'package:flutter_app_to_do/provider/list_provider.dart';
import 'package:flutter_app_to_do/theme/my_theme.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit_task';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime selectedDate = DateTime.now();
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  late ListProvider listProvider;
  Task? task;

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      task = ModalRoute.of(context)!.settings.arguments as Task;
      selectedDate = task!.dateTime!;
      titleController.text = task!.title ?? '';
      descriptionController.text = task!.description ?? '';
    }
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenSize.height * .1,
                color: MyTheme.primarylight,
              ),
              provider.isDarkMode()
                  ? Center(
                      child: Container(
                        height: screenSize.height * .7,
                        width: screenSize.width * .8,
                        margin: EdgeInsets.only(top: screenSize.height * 0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyTheme.primarydark,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(children: [
                          Text(
                            'Edit Task',
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    controller: titleController,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'please enter task title';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'This is title',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    controller: descriptionController,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'please enter description';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'this task details',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    maxLines: 4,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'select_data',
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      EditTask();
                                    },
                                    child: Text(
                                      'Save changes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: MyTheme.whitecolor),
                                    ))
                              ],
                            ),
                          )
                        ]),
                      ),
                    )
                  : Center(
                      child: Container(
                        height: screenSize.height * .7,
                        width: screenSize.width * .8,
                        margin: EdgeInsets.only(top: screenSize.height * 0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyTheme.whitecolor,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(children: [
                          Text(
                            'Edit Task',
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    controller: titleController,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'please enter task title';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'This is title',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    controller: descriptionController,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'please enter description';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'this task details',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    maxLines: 4,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'select_data',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      EditTask();
                                    },
                                    child: Text(
                                      'Save changes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ))
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
            ],
          )
        ],
      ),
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

  void EditTask() {
    if (formkey.currentState?.validate() == true) {
      task!.title = titleController.text;
      task!.description = descriptionController.text;
      task!.dateTime = selectedDate;
      var authprovider = Provider.of<AuthProvider>(context, listen: false);
      // todo show loading
      DialogUtils.showLoading(context, 'Waiting...');
      FirebaseUtils.editTask(task!, authprovider.currentUser!.id!)
          .then((value) {
        // todo hide loading
        DialogUtils.hideLoading(context);
        // todo show message
        DialogUtils.showMessage(context, 'Todo succuessfully',
            posActionName: 'ok');
        print('todo edited succuessfully');
        listProvider.getAllTasksFromFireStore(authprovider.currentUser!.id!);
        Navigator.pop(context);
      }).timeout(Duration(microseconds: 500), onTimeout: () {
        print('todo edited succuessfully');
        listProvider.getAllTasksFromFireStore(authprovider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}
