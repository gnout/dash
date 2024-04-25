import 'package:dash/services/session.dart';
import 'package:flutter/material.dart';

abstract class ExampleTile extends StatelessWidget {
  const ExampleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final String title;
  final String subTitle;

  void onTap(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subTitle),
          enabled: true,
          onTap: () async {
            onTap(context);
          },
        ),
      ),
    );
  }
}

class MenuTile extends ExampleTile {
  const MenuTile({
    super.key,
    required super.icon,
    required super.title,
    required super.subTitle,
    required this.route,
    this.checkUserId = true,
  });

  final String route;
  final bool checkUserId;

  @override
  void onTap(BuildContext context) async {
    if ((checkUserId) && (Session.userId.isEmpty)) {
      return;
    }

    await Navigator.pushNamed(context, route);
  }
}

class MenuModal extends ExampleTile {
  const MenuModal({
    super.key,
    required super.icon,
    required super.title,
    required super.subTitle,
    required this.modalScreen,
  });

  final Widget modalScreen;

  @override
  void onTap(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => modalScreen,
        fullscreenDialog: true,
      ),
    );
  }
}

class MenuModalBottomSheet extends ExampleTile {
  const MenuModalBottomSheet({
    super.key,
    required super.icon,
    required super.title,
    required super.subTitle,
    required this.modalScreen,
  });

  final Widget modalScreen;

  @override
  void onTap(BuildContext context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SafeArea(child: modalScreen),
    );
  }
}