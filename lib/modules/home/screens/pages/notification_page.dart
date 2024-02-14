import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: notificationItem(),
      ),
    );
  }

  notificationItem() => Builder(
        builder: (BuildContext context) {
          return ListView(
            children: ListTile.divideTiles(context: context, tiles: const [
              ListTile(
                leading: Icon(Icons.notification_important_outlined),
                title: Text('Pemberitahuan'),
                subtitle: Text('Terdapat pengumuman penting'),
              ),
              ListTile(
                leading: Icon(Icons.notifications_none_outlined),
                title: Text('Pengumuman'),
                subtitle: Text('Terdapat perubahan aturan'),
              ),
              ListTile(
                leading: Icon(Icons.notification_important),
                title: Text('Proyek Akhir'),
                subtitle: Text('Proyek Akhir membuat aplikasi'),
              ),
              ListTile(
                leading: Icon(Icons.edit_notifications_outlined),
                title: Text('Pengumuman'),
                subtitle: Text('Sentuh untuk melihat lebih detail'),
              )
            ]).toList(),
          );
        },
      );
}
