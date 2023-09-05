import 'package:flutter/material.dart';
import 'package:tpm/components/colors.dart';

class CustomTextField extends StatelessWidget {
  String? labeltext;
  String? hinttext;
  String? validationtext;
  bool pickdate = false;
  int maxlines = 1;
  bool? isenabled = true;
  TextEditingController? controller;
  TextInputType keyboardtype;

  CustomTextField(
      {super.key,
      this.labeltext,
      this.hinttext,
      this.controller,
      this.validationtext,
      this.isenabled,
      required this.maxlines,
      required this.pickdate,
      required this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.0,
      shadowColor: DynamicColor.primaryColor,
      child: Theme(
          data: ThemeData(
            primaryColor: DynamicColor.primaryColor,
            primaryColorDark: DynamicColor.primaryColor,
          ),
          child: TextFormField(
            keyboardType: keyboardtype,
            enabled: isenabled,
            controller: controller,
            decoration: InputDecoration(
              labelText: labeltext,
              hintText: hinttext,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: pickdate
                  ? IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          controller!.text = picked.toString();
                          // setState(() {
                          //   selectedDate = picked;
                          // });
                        }
                      },
                    )
                  : null,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return validationtext;
              }
              return null;
            },
            maxLines: maxlines,
          )),
    );
  }
}
