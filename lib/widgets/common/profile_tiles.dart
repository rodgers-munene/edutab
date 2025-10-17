import 'package:flutter/material.dart';

class ProfileTiles extends StatefulWidget {
  const ProfileTiles({super.key});

  @override
  State<ProfileTiles> createState() => _ProfileTilesState();
}

class _ProfileTilesState extends State<ProfileTiles> {
  bool _isSwitchToggled = false;

  void _handleSwitch(bool value) {
    setState(() {
      _isSwitchToggled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.lock_outline_rounded),
          title: Text("Support"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.notifications_active),
          title: Text("Notifications"),
          trailing: Switch(value: _isSwitchToggled, onChanged: _handleSwitch),
          onTap: () {
            setState(() {
              _handleSwitch(!_isSwitchToggled);
            });
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.support_agent),
          title: Text("Update password"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }
}
