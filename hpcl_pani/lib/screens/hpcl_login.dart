import 'package:flutter/material.dart';
import 'package:hpcl_pani/screens/hpcl_countscreen.dart';

import 'package:sizer/sizer.dart';

import '../model/hpcl_model.dart';
import '../model/hpcl_order_model.dart';

class HpclSelectDealer extends StatefulWidget {
  const HpclSelectDealer({super.key});

  @override
  State<HpclSelectDealer> createState() => _HpclSelectDealerState();
}

class _HpclSelectDealerState extends State<HpclSelectDealer> {
  String dropdownvalue = '';
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hpclData = ModalRoute.of(context)!.settings.arguments as HpclData;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              hpclData.stationName,
            ),
            backgroundColor: const Color.fromARGB(255, 0, 10, 100),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bottel1.jpg')),
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 40.h,
                      width: 70.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.w),
                          child: Image.asset('assets/images/hp_login.jpeg'))),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your name';
                        }
                        return null;
                      },
                      key: _formKey,
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: 'CSA Name',
                          hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 10, 100)),
                          )),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                      width: 100.w,
                      height: 7.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 10, 100)),
                          onPressed: () {
                            if (_nameController.text.isEmpty) {
                              return;
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HpclPaniCountScreen(),
                                    settings: RouteSettings(
                                        arguments: OrderModel(
                                            hpclData.stationName,
                                            _nameController.text,
                                            0.0,
                                            0,
                                            0))));
                          },
                          child: const Text('Submit')))
                ]),
          ),
        ));
  }
}
