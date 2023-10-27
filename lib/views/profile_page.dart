import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const String routeName = "/profile_page";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? version;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      version = packageInfo.version;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBarWidget(),
        body: _bodyWidget(),
      ),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackButton(),
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      elevation: 0.5,
      title: Text(
        'Profile',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Version : ${version ?? '0.0.1'}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
