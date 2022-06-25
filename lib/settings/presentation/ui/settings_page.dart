import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  final Function(int) blockListCallback;

  SettingsPage({required this.blockListCallback});

  @override
  Widget build(BuildContext context) => Container(
    height: double.infinity,
    child: ListView(
      padding: EdgeInsets.all(16),
      children: [
        _getTile(
          "Block List",
          "See all the list of blocked contacts",
          onTap: (){
            blockListCallback(3);
          },
        ),
        _getTile(
          "Dark Mode",
          "Set the app theme to dark",
          onTap: (){

          },
        ),
        _getTile(
          "Backup",
          "Sync your data to cloud for backup",
          onTap: (){

          },
        ),
        _getTile(
          "App Version",
          "1.0",
          onTap: (){

          },
          hasDivider: false,
        ),
      ],
    ),
  );

  Widget _getTile(String title, String subtitle, {onTap, hasDivider = true}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        hasDivider ? Divider(height: 1, color: Colors.grey,) : SizedBox(),
      ],
    );
  }
}