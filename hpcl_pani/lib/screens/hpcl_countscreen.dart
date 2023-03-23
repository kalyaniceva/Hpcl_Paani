import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpcl_pani/screens/hpcl_summaryscreen.dart';

import 'package:sizer/sizer.dart';

import '../model/hpcl_order_model.dart';

class HpclPaniCountScreen extends StatefulWidget {
  const HpclPaniCountScreen({super.key});

  @override
  State<HpclPaniCountScreen> createState() => _HpclPaniCountScreenState();
}

class _HpclPaniCountScreenState extends State<HpclPaniCountScreen> {
  final TextEditingController _countController = TextEditingController();
  List<String> items = ['ARTOS', 'KINLEY'];
  String selectVal = 'ARTOS';
  List<String> quantity = ['500ml', '1 litre', '20litre'];
  String selectquantity = '1 litre';
  double amount = 0.0;
  double commission = 0.0;
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as OrderModel?;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            data!.outletName ?? "",
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
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: Text('Distributor:',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 0, 10, 100)),
                          )),
                          value: selectVal,
                          items: items.map((itemone) {
                            return DropdownMenuItem(
                                value: itemone, child: Text(itemone));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectVal = value.toString();
                            });
                          }),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: 40.w,
                      child: Text('Package:',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 0, 10, 100)),
                          )),
                          value: selectquantity,
                          items: quantity.map((itemone) {
                            return DropdownMenuItem(
                                value: itemone, child: Text(itemone));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectquantity = value.toString();
                            });
                          }),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: 100.w,
                      child: Text('Quantity to be Ordered:',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color.fromARGB(255, 0, 10, 100),
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return 'Please Enter Quantity';
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _countController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            hintText: 'Select Quantity',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 10, 100)),
                            )),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              amount = 0;
                              commission = 0;
                            });
                            return;
                          }
                          setState(() {
                            amount = calculateAmount();
                            commission = calculateCommission();
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 23.h),
                    Text('Amount =$amount',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 3.h),
                    Text('Commission earned=$commission',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.bold)),
                  ],
                )),
            const Spacer(),
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 10, 100)),
                  onPressed: () {
                    if (_countController.text.isEmpty) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HpclSummaryScreen(),
                            settings: RouteSettings(
                                arguments: OrderModel(
                                    data.outletName,
                                    data.csaName,
                                    amount,
                                    int.parse(_countController.text),
                                    commission))));
                  },
                  child: const Text('Place Order')),
            ),
          ],
        ),
      ),
    );
  }

  calculateAmount() {
    switch (selectquantity) {
      case '1 litre':
        return (double.parse(_countController.text) * 12 * 15);

      default:
        return 0.0;
    }
  }

  calculateCommission() {
    switch (selectquantity) {
      case '1 litre':
        return (double.parse(_countController.text) * 12 * 5);

      default:
        return 0.0;
    }
  }
}
