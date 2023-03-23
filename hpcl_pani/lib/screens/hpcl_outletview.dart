import 'package:flutter/material.dart';
import 'package:hpcl_pani/repository/hpcl_repository.dart';
import 'package:hpcl_pani/screens/hpcl_login.dart';
import 'package:sizer/sizer.dart';

class HpclView extends StatefulWidget {
  const HpclView({super.key});

  @override
  State<HpclView> createState() => _HpclViewState();
}

class _HpclViewState extends State<HpclView> {
  String searchString = "";
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('HPCL PAANI'),
          backgroundColor: const Color.fromARGB(255, 0, 10, 100),
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bottel1.jpg')),
          ),
          child: FutureBuilder(
            future: HpclRepository(context).getDetailsFromDB(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 1.h, left: 3.w, right: 3.w, bottom: 1.h),
                      child: TextField(
                        controller: controller,
                        style: TextStyle(fontSize: 10.sp),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 0, 10, 100),
                            ),
                            hintText: 'Select the nearest dealership',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 10, 100)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 10, 100))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 10, 100)))),
                        onChanged: (value) {
                          setState(() {
                            searchString = value.toLowerCase();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 78.h,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            HpclRepository(context).apiCall();
                          });
                        },
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 0.2.h),
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              return snapshot.data![index].stationName
                                          .toLowerCase()
                                          .contains(searchString) ||
                                      snapshot.data![index].outletID
                                          .toLowerCase()
                                          .contains(searchString)
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HpclSelectDealer(),
                                                settings: RouteSettings(
                                                    arguments: snapshot
                                                        .data![index])));
                                      },
                                      child: Card(
                                          elevation: (0.2).h,
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              distanceIcon(snapshot.data![index]
                                                  .distanceCalculated),
                                              Container(
                                                width: 70.w,
                                                height: 10.h,
                                                padding: EdgeInsets.only(
                                                    left: 1.w,
                                                    top: 1.h,
                                                    right: 1.w,
                                                    bottom: 1.h),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${snapshot.data![index].outletID}-${snapshot.data![index].stationName}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                0,
                                                                10,
                                                                100),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                        '${snapshot.data![index].city},${snapshot.data![index].district},${snapshot.data![index].state}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 8.sp,
                                                            color: Colors
                                                                .grey[800],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(
                                                        snapshot.data![index]
                                                            .salesArea,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 8.sp,
                                                            color: Colors
                                                                .grey[800],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                  : Container();
                            })),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  Widget distanceIcon(String? distance) {
    return Container(
        padding: EdgeInsets.only(left: 3.w, top: 3.h, right: 1.w, bottom: 1.h),
        height: 10.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on,
              color: Color.fromARGB(255, 188, 39, 34),
            ),
            Text('$distance Km',
                style: TextStyle(
                    fontSize: 8.sp,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500))
          ],
        ));
  }
}
