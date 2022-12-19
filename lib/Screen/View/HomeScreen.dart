import 'package:exampr/Screen/controller/HomeController.dart';
import 'package:exampr/Screen/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtprice = TextEditingController();

  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    DbHelper db = DbHelper();
    controller.productList.value = await db.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffbdbdbd),
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Market",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            SlideCountdownSeparated(


              duration: Duration(seconds: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: ElevatedButton(onPressed: (){}, child: Text("Start")),
            )
          ]),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: controller.productList.value.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                                height: 140,
                                child: Image.network(
                                    "https://m.media-amazon.com/images/I/611mRs-imxL._SX522_.jpg")),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${controller.productList.value[index]['name']}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "\u{20B9} ${controller.productList.value[index]['price']}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Product Details",
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: txtname,
                      decoration: InputDecoration(
                          hintText: "Product Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 4),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: txtprice,
                      decoration: InputDecoration(
                          hintText: "Product Price",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 4),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          DbHelper db = DbHelper();
                          db.datainsert(txtname.text, txtprice.text);
                          Get.back();
                        },
                        child: Text("Submit"))
                  ],
                ),
              ));
        },
        child: Icon(Icons.add),
      ),
    ));
  }
}
