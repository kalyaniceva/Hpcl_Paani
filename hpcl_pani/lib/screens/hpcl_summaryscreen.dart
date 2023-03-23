import 'package:flutter/material.dart';
import 'package:hpcl_pani/screens/hpcl_upipayment.dart';
import 'package:sizer/sizer.dart';
import '../model/hpcl_order_model.dart';

class HpclSummaryScreen extends StatefulWidget {
  const HpclSummaryScreen({super.key});

  @override
  State<HpclSummaryScreen> createState() => _HpclSummaryScreenState();
}

class _HpclSummaryScreenState extends State<HpclSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as OrderModel?;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Order Summary'),
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Outlet Name:',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      Text(' ${data!.outletName}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('CSA Name:',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      Text(' ${data.csaName}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('Quantity Ordered:',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      Text(' ${data.quantity}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('Commission earned:',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      Text(' ${data.commission}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('Amount to be paid:',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      Text(' ${data.amount}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: 40.h,
                          width: 70.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.w),
                              child:
                                  Image.asset('assets/images/hp_login.jpeg'))),
                    ]),
              ),
              const Spacer(),
              SizedBox(
                width: 100.w,
                height: 7.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 10, 100)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HpclUpiView(),
                          ));
                    },
                    child: const Text('Pay Now')),
              ),
            ],
          ),
        ));
  }
}
