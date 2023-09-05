import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tpm/components/colors.dart';
import 'package:tpm/controller/tagcontroller.dart';
import 'package:get/get.dart';
import '../../components/dropdown.dart';
import '../../components/textfield.dart';

class TagCreateScreen extends StatelessWidget {
  const TagCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    TagController controller = Get.find();
    return SafeArea(
      child: GetBuilder<TagController>(builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: const Text(
              'Create Tag',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: controller.isfetchingmachineMasterlookup
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: FormBuilder(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'ISSUED',
                            style: GoogleFonts.poppins(
                                color: DynamicColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CustomTextField(
                          labeltext: 'Issue Tag',
                          hinttext: 'Enter Issue Tag name',
                          validationtext: 'Please enter issue tag name',
                          pickdate: false,
                          isenabled: false,
                          keyboardtype: TextInputType.none,
                          maxlines: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: CustomTextField(
                                labeltext: 'Date of Detection',
                                hinttext: 'mm/dd/yy',
                                validationtext:
                                    'Please enter Date of Detection',
                                pickdate: true,
                                controller: controller.dod,
                                maxlines: 1,
                                keyboardtype: TextInputType.datetime,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: CustomTextField(
                                labeltext: 'Target Days',
                                hinttext: 'Target Days',
                                keyboardtype: TextInputType.number,
                                controller: controller.targetdaysController,
                                validationtext: 'Please enter Target Days',
                                pickdate: false,
                                maxlines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomDropDown(
                            options: controller.machinemasterlookupmodel,
                            hinttext: 'Select Machine',
                            name: 'Machine',
                            isinitialval: false,
                            // onclick: (element) {
                            //   controller.selectMachine(element.keys.first);
                            // },
                            isenabled: true),
                        const SizedBox(
                          height: 10,
                        ),
                        controller.ismachineselected
                            ? CustomDropDown(
                                hinttext: 'Location',
                                name: 'location',
                                options2: List.generate(
                                    controller
                                        .machinemasterlookupmodel!.data!.list!
                                        .where((element) =>
                                            element.id ==
                                            controller.selectedmachineId.value)
                                        .toList()
                                        .length,
                                    (index) => controller
                                        .machinemasterlookupmodel!.data!.list!
                                        .where((element) =>
                                            element.id ==
                                            controller.selectedmachineId.value)
                                        .toList()[index]
                                        .locationName
                                        .toString()
                                        .split('.')
                                        .last),
                                initialvalue: controller.department.value,
                                isinitialval: false,
                                isenabled: true)
                            : CustomDropDown(
                                hinttext: 'Location',
                                name: 'location',
                                options2: [],
                                initialvalue: controller.department.value,
                                isinitialval: false,
                                isenabled: false),
                        const SizedBox(
                          height: 10,
                        ),
                        controller.ismachineselected
                            ? CustomDropDown(
                                hinttext: 'Department',
                                name: 'department',
                                options2: List.generate(
                                    controller
                                        .machinemasterlookupmodel!.data!.list!
                                        .where((element) =>
                                            element.id ==
                                            controller.selectedmachineId.value)
                                        .toList()
                                        .length,
                                    (index) => controller
                                        .machinemasterlookupmodel!.data!.list!
                                        .where((element) =>
                                            element.id ==
                                            controller.selectedmachineId.value)
                                        .toList()[index]
                                        .departmentName
                                        .toString()
                                        .split('.')
                                        .last),
                                isinitialval: false,
                                initialvalue: controller
                                    .machinemasterlookupmodel!.data!.list!
                                    .where((element) =>
                                        element.id ==
                                        controller.selectedmachineId.value)
                                    .toList()
                                    .first
                                    .departmentName
                                    .toString()
                                    .split('.')
                                    .last,
                                isenabled: true)
                            : CustomDropDown(
                                hinttext: 'Department',
                                name: 'department',
                                options2: [],
                                isinitialval: false,
                                initialvalue: controller.department.value,
                                isenabled: false),
                        const SizedBox(
                          height: 10,
                        ),
                        controller.ismachineselected
                            ? controller.isfetchinggetmachinebyId
                                ? const CircularProgressIndicator()
                                : CustomDropDown(
                                    options3: controller.machinesectionbyId,
                                    hinttext: 'Machine Section',
                                    name: 'machinesection',
                                    isinitialval: false,
                                    isenabled: true)
                            : CustomDropDown(
                                options2: [],
                                hinttext: 'Machine Section',
                                name: 'machinesection',
                                isinitialval: false,
                                isenabled: false),
                        const SizedBox(
                          height: 10,
                        ),
                        controller.isfetchinglossCategory
                            ? const CircularProgressIndicator()
                            : CustomDropDown(
                                options4: controller.lossCategorymodel,
                                hinttext: 'Loss Category',
                                isinitialval: false,
                                name: 'losscategory',
                                isenabled: true),
                        const SizedBox(
                          height: 10,
                        ),
                        controller.ismachinesectionselected
                            ? CustomDropDown(
                                options2: List.generate(
                                    controller.machinesectionbyId!.data!
                                        .where((element) =>
                                            element.id ==
                                            controller
                                                .selectedmachinesectionId.value)
                                        .toList()
                                        .length,
                                    (index) => controller
                                        .machinesectionbyId!.data!
                                        .where((element) =>
                                            element.id ==
                                            controller
                                                .selectedmachinesectionId.value)
                                        .toList()[index]
                                        .userName
                                        .toString()),
                                hinttext: 'Assign To',
                                name: 'assignto',
                                isinitialval: false,
                                isenabled: true)
                            : CustomDropDown(
                                options2: const [],
                                hinttext: 'Assign To',
                                name: 'assignto',
                                isinitialval: false,
                                isenabled: false),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          labeltext: 'Problem Statement',
                          hinttext: 'Enter Problem Statement',
                          validationtext: 'Please enter Problem Statement',
                          keyboardtype: TextInputType.text,
                          controller: controller.problemStatementController,
                          pickdate: false,
                          maxlines: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: CustomTextField(
                                labeltext: 'CC',
                                hinttext: 'CC:-',
                                keyboardtype: TextInputType.emailAddress,
                                controller: controller.ccController,
                                validationtext: 'Please enter CC:-',
                                pickdate: false,
                                maxlines: 1,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: CustomTextField(
                                labeltext: 'BCC',
                                hinttext: 'BCC:-',
                                controller: controller.bccController,
                                keyboardtype: TextInputType.emailAddress,
                                validationtext: 'Please enter BCC',
                                pickdate: false,
                                maxlines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.postissueTag();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff003399),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Container(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Photo Library'),
                                onTap: () {
                                  controller
                                      .pickSingleImage(ImageSource.gallery);
                                  // getImageFromGallery();
                                  // Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  controller
                                      .pickSingleImage(ImageSource.camera);
                                  // getImageFromCamera();
                                  // Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              tooltip: 'Pick Image',
              backgroundColor: DynamicColor.primary,
              child: const Icon(Icons.camera)),
        );
      }),
    );
  }
}
