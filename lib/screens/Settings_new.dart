// import 'package:flutter/material.dart';
// import 'package:shared_preferences_settings/shared_preferences_settings.dart';
//
// class Settings_New extends StatefulWidget {
//   const Settings_New({Key? key}) : super(key: key);
//
//   @override
//   State<Settings_New> createState() => _Settings_NewState();
// }
//
// class _Settings_NewState extends State<Settings_New> {
//   @override
//   Widget build(BuildContext context) {
//     return SettingsScreen(
//       title: "Settings",
//       children: [
//         SettingsToggleScreen(
//           settingKey: 'key-of-your-setting',
//           title: 'Title',
//           defaultValue: true,
//           subtitle: 'Enabled',
//           subtitleIfOff: 'Disabled',
//           children: [
//             SettingsContainer(
//               child: Text('This is enabled! :)'),
//             ),
//           ],
//           childrenIfOff: [
//             SettingsContainer(
//               child: Text('Tap the checkbox to enable.'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
