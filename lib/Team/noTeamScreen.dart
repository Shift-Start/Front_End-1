import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'createTeamScreen.dart';

class NoTeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups, size: 120, color: Theme.of(context).primaryColor),
            SizedBox(height: 20),
            Text(
              "No Teams Yet!",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateTeamScreen()),
                );
              },
              child: Text("Create a Team",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
     ),
);
}
}
