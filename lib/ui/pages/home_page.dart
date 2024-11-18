import 'package:app_firebase_auth/services/auth_service.dart';
import 'package:app_firebase_auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello ! ${authService.getCurrentUserEmail()}"),
            CustomButton(height: 200, text: "Logout", onClick: ()=> {
                authService.signOut()
            })
          ],
        ),
      ),
    );
  }
}
