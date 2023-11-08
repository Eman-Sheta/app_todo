import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/auth/login/login_screen.dart';
import 'package:flutter_app_to_do/provider/app_config_prvider.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';
import 'package:flutter_app_to_do/provider/list_provider.dart';
import 'package:flutter_app_to_do/settings/settings_tab.dart';
import 'package:flutter_app_to_do/task_list/Task_List_tab.dart';
import 'package:flutter_app_to_do/task_list/add_task_bottom_sheet.dart';
import 'package:flutter_app_to_do/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selctedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authprovider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context)!.to_do_list} ${authprovider.currentUser?.name ?? ''}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.tasksList = [];
                authprovider.currentUser = null;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: provider.isDarkMode()
          ? BottomAppBar(
              color: MyTheme.primarydark,
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              child: BottomNavigationBar(
                  currentIndex: selctedIndex,
                  onTap: (index) {
                    selctedIndex = index;
                    setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: AppLocalizations.of(context)!.task_list,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: AppLocalizations.of(context)!.settings,
                    )
                  ]),
            )
          : BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              child: BottomNavigationBar(
                  currentIndex: selctedIndex,
                  onTap: (index) {
                    selctedIndex = index;
                    setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: AppLocalizations.of(context)!.task_list,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: AppLocalizations.of(context)!.settings,
                    )
                  ]),
            ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: provider.isDarkMode()
                ? BorderSide(color: MyTheme.primarydark, width: 4)
                : BorderSide(color: MyTheme.whitecolor, width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selctedIndex],
    );
  }

  List<Widget> tabs = [TaskListTab(), SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottomSheet());
  }
}
