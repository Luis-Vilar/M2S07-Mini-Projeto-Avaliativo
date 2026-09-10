import 'package:flutter/material.dart';
import 'package:todo_app/core/routes.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/data/sources/local/shared_preferences.dart';

class LoggedView extends StatefulWidget {
  const new({super.key});

  @override
  State<LoggedView> createState() => _LoggedViewState();
}

class _LoggedViewState extends State<LoggedView> {
  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Fechar sessão'),
          content: const Text('Tem certeza que deseja fechar a sessão atual?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    await removeSessionData();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserLoggedModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.image),
            onBackgroundImageError: (_, _) {},
            child: user.image.isEmpty ? const Icon(Icons.person) : null,
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${user.firstName} ${user.lastName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: .bold),
            ),
            Text(
              user.email,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showLogoutDialog,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            padding: const EdgeInsets.only(right: 24),
          ),
        ],
      ),
    );
  }
}
