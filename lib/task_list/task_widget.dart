import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/Model/task.dart';
import 'package:flutter_app_to_do/auth/Dialog_utils.dart';
import 'package:flutter_app_to_do/firebase_utils.dart';
import 'package:flutter_app_to_do/provider/app_config_prvider.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';
import 'package:flutter_app_to_do/provider/list_provider.dart';
import 'package:flutter_app_to_do/task_list/edit_task_screen.dart';
import 'package:flutter_app_to_do/theme/my_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget({required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var uId =
        Provider.of<AuthProvider>(context, listen: false).currentUser?.id ?? "";
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EditTaskScreen.routeName, arguments: widget.task);
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                onPressed: (context) {
                  FirebaseUtils.deleteTaskFormFireStore(widget.task, uId)
                      .then((value) {
                    // todo hide loading
                    DialogUtils.hideLoading(context);
                    // todo show message
                    DialogUtils.showMessage(context, '');
                    print('todo added succuessfully');
                    listProvider.getAllTasksFromFireStore(uId);
                    Navigator.pop(context);
                  }).timeout(Duration(milliseconds: 500), onTimeout: () {
                    listProvider.getAllTasksFromFireStore(uId);
                  });
                },
                backgroundColor: MyTheme.redcolor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: provider.isDarkMode()
              ? Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: MyTheme.primarydark),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: widget.task.isDone!
                              ? MyTheme.greencolor
                              : Theme.of(context).primaryColor,
                          height: 80,
                          width: 4,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.task.title ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: widget.task.isDone!
                                            ? MyTheme.greencolor
                                            : Theme.of(context).primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.task.description ?? '',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        )),
                        InkWell(
                          onTap: () {
                            // FirebaseUtils.editIsDone(widget.task, uId);
                            widget.task.isDone = !widget.task.isDone!;
                            setState(() {});
                          },
                          child: widget.task.isDone!
                              ? Text(
                                  'Done!',
                                  style: TextStyle(
                                      color: MyTheme.greencolor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              : Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 14),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(Icons.check,
                                      size: 30, color: MyTheme.whitecolor)),
                        ),
                      ]))
              : Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: MyTheme.whitecolor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: widget.task.isDone!
                            ? MyTheme.greencolor
                            : Theme.of(context).primaryColor,
                        height: 80,
                        width: 4,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.task.title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: widget.task.isDone!
                                          ? MyTheme.greencolor
                                          : Theme.of(context).primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.task.description ?? '',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      )),
                      InkWell(
                        onTap: () {
                          // FirebaseUtils.editIsDone(widget.task, uId);
                          widget.task.isDone = !widget.task.isDone!;
                          setState(() {});
                        },
                        child: widget.task.isDone!
                            ? Text(
                                'Done!',
                                style: TextStyle(
                                    color: MyTheme.greencolor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 21),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).primaryColor),
                                child: Icon(Icons.check,
                                    size: 30, color: MyTheme.whitecolor)),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
