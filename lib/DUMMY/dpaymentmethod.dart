import 'package:flutter/material.dart';

class dpaymentmethod extends StatefulWidget {
  static const String id = "dpaymentmethod";
  const dpaymentmethod({Key? key}) : super(key: key);

  @override
  State<dpaymentmethod> createState() => _dpaymentmethodState();
}

class _dpaymentmethodState extends State<dpaymentmethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF30D15D),
        title: const Center(child: Text('Payment Method')),
      ),
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0XFFE9E2E2), Color(0XFF265533),
          ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 100,
                    width: 50,
                    child: Image(image: AssetImage('assets/easypaisalogo.png')),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Easypaisa A/C No 0300xxxxxx format',
                        fillColor: const Color(0XFFFFE3E0),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff2D3142)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff2D3142)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email ******@gmail.com',
                        fillColor: const Color(0XFFFFE3E0),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff2D3142)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff2D3142)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          // Handle the payment action here
                        },
                        child: const Center(
                          child: Text(
                            'Pay Now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Oswald-Medium',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
