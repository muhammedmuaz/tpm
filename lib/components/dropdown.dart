import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpm/components/colors.dart';
import 'package:get/get.dart';
import '../controller/tagcontroller.dart';
import '../model/lossCategory_lookup.dart';
import '../model/machinemaster_lookupModel.dart';
import '../model/section_getmachinebyIdModel.dart';

class CustomDropDown extends StatelessWidget {
  TagController controller = Get.find();

  MachinemasterLookupModel? options;
  List<String>? options2;
  LossCategoryLookup? options4;
  SectionGetmachinebyId? options3;
  String? initialvalue;
  String? hinttext;
  String? name;
  Function(Map<int, String> element)? onclick;
  bool isenabled;
  bool? isinitialval = false;
  CustomDropDown(
      {super.key,
      this.options,
      this.hinttext,
      this.name,
      this.onclick,
      this.options2,
      this.initialvalue,
      this.isinitialval,
      this.options3,
      this.options4,
      required this.isenabled});

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
          child: FormBuilderDropdown(
            name: name!,
            enabled: isenabled,
            initialValue: isinitialval! ? initialvalue : null,
            items: options != null
                ? List.generate(
                    options!.data!.list!.length,
                    (index) => DropdownMenuItem(
                          value: options!.data!.list![index].name.toString(),
                          onTap: () {
                            controller.selectMachine(
                                options!.data!.list![index].departmentId!,
                                options!.data!.list![index].departmentName
                                    .toString(),
                                options!.data!.list![index].locationId!,
                                options!.data!.list![index].locationName
                                    .toString(),
                                options!.data!.list![index].supervisor
                                    .toString(),
                                options!.data!.list![index].supervisorName!);
                            controller.getmachinebyId(
                                options!.data!.list![index].id!,
                                options!.data!.list![index].name.toString());
                          },
                          child:
                              Text(options!.data!.list![index].name.toString()),
                        ))
                : options3 != null
                    ? List.generate(
                        options3!.data!.length,
                        (index) => DropdownMenuItem(
                              onTap: () {
                                controller.selectmachineSection(
                                    options3!.data![index].id!,
                                    options3!.data![index].name.toString());
                                // Name Assigning
                                controller.issuetagform.MachineSectionId =
                                    options4!.data!.list![index].id;
                                controller.issuetagform.MachineSectionName =
                                    options4!.data!.list![index].name
                                        .toString();
                              },
                              value:
                                  '${options3!.data![index].code.toString()}-${options3!.data![index].name.toString()}',
                              child: Text(
                                  '${options3!.data![index].code.toString()}-${options3!.data![index].name.toString()}'),
                            ))
                    : options4 != null
                        ? List.generate(
                            options4!.data!.list!.length,
                            (index) => DropdownMenuItem(
                                  onTap: () {
                                    controller.issuetagform.LossCategoryId =
                                        options4!.data!.list![index].id;
                                    controller.issuetagform.LossCategoryName =
                                        options4!.data!.list![index].name;
                                  },
                                  value:
                                      '${options4!.data!.list![index].code.toString()}-${options4!.data!.list![index].name.toString()}',
                                  child: Text(
                                      '${options4!.data!.list![index].code.toString()}-${options4!.data!.list![index].name.toString()}'),
                                ))
                        : options2!
                            .map((machine) => DropdownMenuItem(
                                  onTap: () {},
                                  value: machine,
                                  child: Text(machine),
                                ))
                            .toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // contentPadding:
              //     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              // fillColor: Colors.grey.withOpacity(0.1),
              // filled: true,
              hintText: hinttext,
            ),
          ),
        ));
  }
}
