import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/provider/app_config_prvider.dart';
import 'package:flutter_app_to_do/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return provider.isDarkMode()
        ? Container(
            color: MyTheme.primarydark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    provider.changeTheme(ThemeMode.dark);
                  },
                  child: provider.isDarkMode()
                      ? getSelectedItemWidget(
                          AppLocalizations.of(context)!.dark)
                      : getUnSelectedItemWidget(
                          AppLocalizations.of(context)!.dark),
                ),
                InkWell(
                    onTap: () {
                      provider.changeTheme(ThemeMode.light);
                    },
                    child: provider.isDarkMode()
                        ? getUnSelectedItemWidget(
                            AppLocalizations.of(context)!.light)
                        : getSelectedItemWidget(
                            AppLocalizations.of(context)!.light)),
              ],
            ),
          )
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    provider.changeTheme(ThemeMode.dark);
                  },
                  child: provider.isDarkMode()
                      ? getSelectedItemWidget(
                          AppLocalizations.of(context)!.dark)
                      : getUnSelectedItemWidget(
                          AppLocalizations.of(context)!.dark),
                ),
                InkWell(
                    onTap: () {
                      provider.changeTheme(ThemeMode.light);
                    },
                    child: provider.isDarkMode()
                        ? getUnSelectedItemWidget(
                            AppLocalizations.of(context)!.light)
                        : getSelectedItemWidget(
                            AppLocalizations.of(context)!.light)),
              ],
            ),
          );
  }

  Widget getSelectedItemWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
            size: 25,
          ),
        ],
      ),
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
