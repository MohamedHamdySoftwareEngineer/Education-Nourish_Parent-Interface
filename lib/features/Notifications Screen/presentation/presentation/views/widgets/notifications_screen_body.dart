import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Notifications%20Screen/presentation/presentation/views/widgets/neo_notification.dart';
import 'package:flutter/material.dart';

class NotificationsScreenBody extends StatelessWidget {
   NotificationsScreenBody({super.key});
  final List<NeoNotification> notifications = [
    NeoNotification(
      title: 'The results are in! Your earnings added up to \$0.04 in October.',
      time: '5h',
    ),
    NeoNotification(
      title:
          'Get a more rewarding experience with the Mobile & Personal Protection Bundle.',
      time: '1d',
    ),
    NeoNotification(
      title:
          'Welcome to Neo Money™! Don\'t forget to make a deposit to start earning 2.25% interest*.',
      time: '3d',
    ),
    NeoNotification(
      title:
          'Don\'t miss out! For a limited time, get up to \$85* for each friend you refer to Neo.',
      time: '4d',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(appBartTitle: 'Notifications',
      child: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(context, notification);
              },
            )
          : Scaffold(
              body: Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Image.asset(
                        'assets/student/Home_Student/NoNotifiactionsAlarm.png'),
                  ),
                  const Text(
                    'you are all caught up!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Check back later for updates and reminders.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              )),
            ),
    
    );
  }
}

Widget _buildNotificationItem(
    BuildContext context, NeoNotification notification) {
  return ListTile(
    leading: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'Edu',
        ),
      ),
    ),
    title: Text(
      notification.title,
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          notification.time,
          style: const TextStyle(color:Colors.black),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {},
          color: Colors.black,
        ),
      ],
    ),
  );
}