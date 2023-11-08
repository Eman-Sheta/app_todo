import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/provider/app_config_prvider.dart';
import 'package:flutter_app_to_do/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LangusgeBottomSheet extends StatefulWidget {
  @override
  State<LangusgeBottomSheet> createState() => _LangusgeBottomSheetState();
}

class _LangusgeBottomSheetState extends State<LangusgeBottomSheet> {
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
                    provider.changeLanguage('en');
                  },
                  child: provider.appLanguage == 'en'
                      ? getSelectedItemWidget(
                          AppLocalizations.of(context)!.english)
                      : getUnSelectedItemWidget(
                          AppLocalizations.of(context)!.english),
                ),
                InkWell(
                  onTap: () {
                    provider.changeLanguage('ar');
                  },
                  child: provider.appLanguage == 'ar'
                      ? getSelectedItemWidget(
                          AppLocalizations.of(context)!.arabic)
                      : getUnSelectedItemWidget(
                          AppLocalizations.of(context)!.arabic),
                ),
              ],
            ),
          )
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    provider.changeLanguage('en');
                  },
                  child: provider.appLanguage == 'en'
                      ? getSelectedItemWidget(
                          AppLocalizations.of(context)!.english)
                      : getUnSelectedItemWidget(
                          AppLocalizations.of(context)!.english),
                ),
                InkWell(
                  onTap: () {
                    provider.changeLanguage('ar');
                  },
                  child: provider.appLanguage == 'ar'
                      ? getSelectedItemWidget(
                          AppLocalizations.of(context)!.arabic)
                      : getUnSelectedItemWidget(
                          AppLocalizations.of(context)!.arabic),
                ),
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
