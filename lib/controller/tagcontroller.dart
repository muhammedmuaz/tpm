import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tpm/network/api.dart';
import '../model/issueTag_lookupModel.dart';
import '../model/lossCategory_lookup.dart';
import '../model/machinemaster_lookupModel.dart';
import '../model/section_getmachinebyIdModel.dart';
import 'package:image_picker/image_picker.dart';

import '../view/tags/AddTagonScreen.dart';

class TagController extends GetxController {
  MachinemasterLookupModel? machinemasterlookupmodel;
  SectionGetmachinebyId? machinesectionbyId;
  LossCategoryLookup? lossCategorymodel;
  IssueTagLookup? issueTagmodel;
  bool isfetchingmachineMasterlookup = false;
  bool isfetchinggetmachinebyId = false;
  RxInt selectedmachineId = 0.obs;
  RxInt selectedmachinesectionId = 0.obs;
  bool isfetchinglossCategory = false;
  bool isfetchingTagsdata = false;
  Map<int, String> machinecode = {};
  bool ismachinesectionselected = false;
  RxString department = ''.obs;
  RxString location = ''.obs;
  bool ismachineselected = false;
  final ImagePicker tagImagepicker = ImagePicker();
  File? tagImage;
  issteTagPost issuetagform = issteTagPost();
  TextEditingController dod = TextEditingController();
  TextEditingController targetdaysController = TextEditingController();
  TextEditingController problemStatementController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController bccController = TextEditingController();

  // File get image => tagImage!;

  machineMasterlookup() async {
    isfetchingmachineMasterlookup = true;
    String? url;
    url = 'api/MachineMaster/Lookup';
    var response = await Api().get('${baseUrl}api/MachineMaster/Lookup');
    if (response != null) {
      machinemasterlookupmodel = machinemasterLookupModelFromJson(response);
      for (var i = 0; i < machinemasterlookupmodel!.data!.list!.length; i++) {
        machinecode.addAll({
          machinemasterlookupmodel!.data!.list![i].id!:
              machinemasterlookupmodel!.data!.list![i].name.toString()
        });
      }
    }
    isfetchingmachineMasterlookup = false;
    update();
  }

  selectMachine(int departmentId, String departmentName, int locationId,
      String locationName, String supervisor, String supervisorname) {
    issuetagform.DepartmentId = departmentId;
    issuetagform.LocationId = locationId;
    issuetagform.DepartmentName = departmentName;
    issuetagform.LocationName = locationName;
    issuetagform.Supervisor = supervisor;
    issuetagform.SupervisorName = supervisorname;

    //Add Department
    department(departmentName);
    location(locationName);
    ismachineselected = true;
    update();
  }

  issueTag() async {
    String? url;
    url = 'api/IssueTag/lookup';
    isfetchingTagsdata = true;
    var response = await Api().get(baseUrl + url);
    if (response != null) {
      print(response.toString());
      issueTagmodel = issueTagLookupFromJson(response);
    }
    isfetchingTagsdata = false;
    update();
  }

  getmachinebyId(int id, String machinename) async {
    isfetchinggetmachinebyId = true;
    issuetagform.machineId = id;
    issuetagform.machineName = machinename;
    selectedmachineId(id);
    String? url;
    url = 'api/Section/GetByMachineId/$id';
    var response = await Api().get(baseUrl + url);
    if (response != null) {
      machinesectionbyId = sectionGetmachinebyIdFromJson(response);
    }
    isfetchinggetmachinebyId = false;
    update();
  }

  selectmachineSection(int id, String machineSectionName) {
    // issuetagform.machineId = id;
    // issuetagform.MachineSectionName = machineSectionName;
    selectedmachinesectionId(id);
    ismachinesectionselected = true;
    update();
  }

  getlossCategory() async {
    isfetchinglossCategory = true;
    String? url;
    url = 'api/LossCategory/Lookup';
    var response = await Api().get(baseUrl + url);
    if (response != null) {
      lossCategorymodel = lossCategoryLookupFromJson(response);
    }
    isfetchinglossCategory = false;
    update();
  }

  Future<void> pickMultiImages() async {
    final pickedFiles = await tagImagepicker.pickMultiImage();
    if (pickedFiles != null) {
      for (var pickedFile in pickedFiles) {
        tagImage = File(pickedFile.path);
      }
      update();
    }
  }

  Future<void> pickSingleImage(ImageSource source) async {
    final pickedFile = await tagImagepicker.pickImage(source: source);
    if (pickedFile != null) {
      if (pickedFile != null) {
        tagImage = File(pickedFile.path);
        Get.to(AddTagonScreen(image: tagImage!));
        update();
      }
      update();
    }
  }

  deleteTag(int id) async {
    String? url;
    url = 'api/IssueTag/$id';

    Api().delete(
      baseUrl + url,
    );
    BotToast.showText(text: "Tag Deleted");
  }

  postissueTag() async {
    String? url;
    url = 'api/IssueTag';
    String userid = Api().sp.read('userId');
    print(issuetagform.machineId);
    print({
      'Id': null,
      'Detector': userid,
      'MachineId': issuetagform.machineId,
      'MachineName': issuetagform.machineName,
      'DepartmentId': issuetagform.DepartmentId,
      'DepartmentName': issuetagform.DepartmentName,
      'LocationId': issuetagform.LocationId,
      'LocationName': issuetagform.LocationName,
      'Supervisor': issuetagform.Supervisor,
      'UserId': userid,
      'SupervisorName': issuetagform.SupervisorName,
      'LossCategoryId': issuetagform.LossCategoryId,
      'LossCategoryName': issuetagform.LocationName,
      'MachineSectionName': issuetagform.MachineSectionName,
      'MachineSectionId': issuetagform.MachineSectionId,
      'Remarks': 'SWITCH_REPAIR_DONE',
      'ProblemDesc': problemStatementController.text,
      'FTagStatus': 'issued',
      'TargetDays': targetdaysController.text,
      'DateofDetection': dod.text,
      'Images': null,
      'ImagesAsg': null,
      'files': issuetagform.file,
      'filesAsg': null,
    });
    Api().post(baseUrl + url, queryParams: {
      'cc': ccController.text,
      'bcc': bccController.text
    }, body: {
      'Id': null,
      'Detector': userid,
      'MachineId': issuetagform.machineId,
      'MachineName': issuetagform.machineName,
      'DepartmentId': issuetagform.DepartmentId,
      'DepartmentName': issuetagform.DepartmentName,
      'LocationId': issuetagform.LocationId,
      'LocationName': issuetagform.LocationName,
      'Supervisor': issuetagform.Supervisor,
      'UserId': userid,
      'SupervisorName': issuetagform.SupervisorName,
      'LossCategoryId': issuetagform.LossCategoryId,
      'LossCategoryName': issuetagform.LocationName,
      'MachineSectionName': issuetagform.MachineSectionName,
      'MachineSectionId': issuetagform.MachineSectionId,
      'Remarks': 'SWITCH_REPAIR_DONE',
      'ProblemDesc': problemStatementController.text,
      'FTagStatus': 'issued',
      'TargetDays': targetdaysController.text,
      'DateofDetection': dod.text,
      'Images': null,
      'ImagesAsg': null,
      'files': issuetagform.file,
      'filesAsg': null,
    });

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    issueTag();
    getlossCategory();
    machineMasterlookup();
  }
}

class issteTagPost {
  String? cc = '';
  String? bcc = '';
  int? id = 1;
  String? Detector = '';
  int? machineId = 0;
  String? machineName = '';
  int? DepartmentId = 0;
  String? DepartmentName = '';
  int? LocationId = 0;
  String? LocationName = '';
  String? Supervisor = '';
  String? UserId = '';
  String? SupervisorName = '';
  int? LossCategoryId = 0;
  String? LossCategoryName = '';
  String? MachineSectionName = '';
  int? MachineSectionId = 0;
  String? Remarks = '';
  String? ProblemDesc = '';
  String? FTagStatus = '';
  int? TargetDays = 0;
  String? DateofDetection = '';
  File? file = File('');

// ignore: non_constant_identifier_names
  issteTagPost(
      {this.cc,
      this.DepartmentId,
      this.DateofDetection,
      this.DepartmentName,
      this.Detector,
      this.FTagStatus,
      this.LocationId,
      this.LocationName,
      this.LossCategoryId,
      this.LossCategoryName,
      this.MachineSectionId,
      this.MachineSectionName,
      this.ProblemDesc,
      this.Remarks,
      this.Supervisor,
      this.SupervisorName,
      this.TargetDays,
      this.UserId,
      this.bcc,
      this.file,
      this.id,
      this.machineId,
      this.machineName});
}
