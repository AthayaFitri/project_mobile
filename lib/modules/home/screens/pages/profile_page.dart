// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../../api/app_routes.dart';
import '../../../../utils/services/local_storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade800,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 8,
            ),
            child: IconButton(
              onPressed: () => showSettings(context),
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.indigo.shade800,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.indigo.shade400,
                    child: const CircleAvatar(
                      radius: 70,
                      foregroundImage: AssetImage('assets/images/email.png'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: const Text(
                      'Athaya Rizqia Fitriani',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    child: const Text(
                      'athayarizqiafitriani@gmail.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Post',
                ),
                Tab(
                  text: 'Tagged',
                ),
              ],
              labelColor: Colors.indigo,
            ),
          ),
          SizedBox(
            height: 330,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 380,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  'Mata kuliah pemrograman mobile sama Pak Bagus itu bener-bener keren! Tugasnya memang agak berat, tapi serunya level dewa. Pak Bagus memberi tugas untuk membuat aplikasi kalkulator, stopwatch, sampe aplikasi hitung luas dan keliling bangun datar. Awalnya sih ngerasa challenging, tapi pas udah jadi, rasanya kayak bawa pulang piala emas. Makasih banyak, Pak Bagus, udah ngasih tugas yang bikin kita paham dan bangga sama kemampuan ngoding kita sendiri! Walau kadang sambil ngeluh dikit sih, tapi semua itu worth it! 👨‍💻🌟😅👨‍💻🌟',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'avenir',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 380,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 227, 232, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  'Pak Bagus yang baik hati, mungkin ada sedikit saran agar belajar mobile makin enjoyable! Pertama, semoga soalnya bisa dibikin lebih simpel dikit pas awal, agar yang baru belajar bisa tetap bersemangat. Terus, semoga deadline-nya bisa dibuat panjang Pak, biar ga pada keringet dingin begadang Pak hehe. Terakhir, tugasnya kalau bisa dikit-dikit aja ya Pak, biar semuanya bisa pada senyum Pepsodent. Semoga saran ini bisa bikin suasana belajar mobile makin asik dan semoga Pak Bagus selalu sehat dan ceria ya Pak! 😊📚⏰🎉',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'avenir',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /* Center(
                  child: Container(
                    width: 380,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Mata kuliah pemrograman mobile sama Pak Bagus itu bener-bener keren! Tugasnya memang agak berat, tapi serunya level dewa. Pak Bagus memberi tugas untuk membuat aplikasi kalkulator, stopwatch, sampe aplikasi hitung luas dan keliling bangun datar. Awalnya sih ngerasa challenging, tapi pas udah jadi, rasanya kayak bawa pulang piala emas. Makasih banyak, Pak Bagus, udah ngasih tugas yang bikin kita paham dan bangga sama kemampuan ngoding kita sendiri! Walau kadang sambil ngeluh dikit sih, tapi semua itu worth it! 👨‍💻🌟😅 👨‍💻🌟',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'avenir',
                          ),
                        ),
                      ),
                    ),
                  ),
                ), */
                const Center(
                  child: Text('Tagged Feed'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showSettings(BuildContext context) => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: settingsItem(),
        );
      });

  Widget settingsItem() => Builder(
        builder: (BuildContext context) {
          return ListView(
            shrinkWrap: true,
            children: [
              const ListTile(
                leading: Icon(Icons.notifications_active_outlined),
                title: Text('Notification'),
                subtitle: Text('Atur segala jenis pesan notifikasi'),
              ),
              const ListTile(
                leading: Icon(Icons.privacy_tip_outlined),
                title: Text('Privasi Akun'),
                subtitle: Text('Atur Penggunaan data'),
              ),
              const ListTile(
                leading: Icon(Icons.edit_note_outlined),
                title: Text('Edit Akun'),
                subtitle: Text('Atur Akun data'),
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
                onTap: () async {
                  await LocalStorageService.signOut();
                  Navigator.popAndPushNamed(context, AppRoutes.login);
                },
              ),
            ],
          );
        },
      );
}
