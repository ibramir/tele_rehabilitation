import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/utils/auth_service.dart';
import 'package:tele_rehabilitation/utils/widget_factory.dart';
import 'package:tele_rehabilitation/widgets/default_app_bar.dart';
import 'package:tele_rehabilitation/widgets/main_drawer.dart';

import '../model/doctor_data.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF0F0F0),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: DefaultAppBar(
            title: Text(
              'Contact Doctor',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'proxima_ssv',
                fontSize: 35,
              ),
            ),
          )
        ),
        drawer: const MainDrawer(),
        body: FutureBuilder(
          future: AuthService().getDoctor(),
          builder: (BuildContext context, AsyncSnapshot<DoctorData> snapshot) {
            if (snapshot.hasData) {
              DoctorData doctor = snapshot.data!;
              return Align(
                alignment: Alignment.topCenter,
                child: WidgetFactory.card(
                    margin: const EdgeInsets.all(24),
                    child: Container(
                        padding: const EdgeInsets.all(32),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  height: 2, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Dr. ${doctor.name}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'proxima_ssv',
                                        fontSize: 25)),
                                const TextSpan(
                                    text: '\nPhone Number\t\t',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: doctor.phoneNumber),
                                const TextSpan(
                                    text: '\nLandline Number\t\t',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: doctor.landline),
                                const TextSpan(
                                    text: '\nLocation\t\t',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: doctor.location)
                              ]),
                        ))),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
