import 'package:flutter/material.dart';

class InternetException extends StatefulWidget {

  final VoidCallback  onPress;

  const InternetException({super.key, required this.onPress});

  @override
  State<InternetException> createState() => _InternetExceptionState();
}

class _InternetExceptionState extends State<InternetException> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * .15,),

        const Icon(Icons.cloud_off, color: Colors.red, size: 50,),

        Padding(
          padding: const EdgeInsets.only(top: 30),
        child: Text('We are unable to show results\n'
        'Please check you internet data\nconnection'
        ,textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)
        )),
        SizedBox(height: MediaQuery.of(context).size.height * .1,),
        ElevatedButton(
          onPressed: (){

          }, 
          child: Text('Retry', style: Theme.of(context).textTheme.bodySmall!))
      ],
    );
  }
}