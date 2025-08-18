import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override

  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          "FeedBack",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: (){
              // configurar ainda
            }
          ),
        ],

        backgroundColor:  const Color(0xFFCD853F),
        elevation: 0,
      ), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //data
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color:  const Color(0xFFCD853F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Dia 04/07",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              )
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:  const Color(0xFFCD853F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seu feedback',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )
                  ),

                  const SizedBox(height: 10),

                  Container(
                    height: 150,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Sinto muita dor aiaiaiai....", style: TextStyle(fontSize: 16))
                  )
                ]
              )
            )
            ]
          )
        ),
      )
    );
  }
}