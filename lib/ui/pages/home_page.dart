import 'package:app_firebase_auth/services/auth_service.dart';
import 'package:app_firebase_auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final auth_service = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello ! ${auth_service.getCurrentUser()}"),
            CustomButton(height: 200, text: "Logout", onClick: ()=> {
                auth_service.signOut()
            })
          ],
        ),
      ),
    );
  }
}
