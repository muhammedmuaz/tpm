import 'package:flutter/material.dart';
import 'package:tpm/components/colors.dart';
import 'package:tpm/view/tags/AddTagScreen.dart';
import '../../controller/logincontroller.dart';
import 'package:get/get.dart';
import '../../controller/tagcontroller.dart';
import 'createtag.dart';

class TagRaisedScreen extends StatelessWidget {
  const TagRaisedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var dynamicHeight = MediaQuery.of(context).size.height;
    var dynamicWidth = MediaQuery.of(context).size.width;
    int _notificationCount = 9;
    TagController controller = Get.find();

    return SafeArea(
      child: GetBuilder<TagController>(builder: (logic) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   title: const Text(
          //     'Tag Raised',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   actions: [
          //     IconButton(
          //       icon: const Icon(
          //         Icons.menu,
          //         color: Colors.black,
          //       ),
          //       onPressed: () {
          //         // Open the sidebar
          //       },
          //     ),
          //     IconButton(
          //       icon: const Icon(
          //         Icons.logout,
          //         color: Colors.black,
          //       ),
          //       onPressed: () {
          //         // Logout the user
          //       },
          //     ),
          //     IconButton(
          //       icon: const Icon(
          //         Icons.settings,
          //         color: Colors.black,
          //       ),
          //       onPressed: () {
          //         // Open the settings page
          //       },
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 5.0),
          //       child: Stack(
          //         children: [
          //           IconButton(
          //             icon: const Icon(
          //               Icons.notifications,
          //               color: Colors.black,
          //             ),
          //             onPressed: () {
          //               // Open the notifications page
          //             },
          //           ),
          //           _notificationCount > 0
          //               ? Positioned(
          //                   right: 0,
          //                   top: 0,
          //                   child: Container(
          //                     padding: const EdgeInsets.all(2),
          //                     decoration: BoxDecoration(
          //                       color: Colors.red,
          //                       borderRadius: BorderRadius.circular(10),
          //                     ),
          //                     constraints: const BoxConstraints(
          //                       minWidth: 16,
          //                       minHeight: 16,
          //                     ),
          //                     child: Text(
          //                       '$_notificationCount',
          //                       style: const TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 10,
          //                       ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                 )
          //               : const SizedBox(),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          body: controller.isfetchingTagsdata
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tag Raised',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                          ),
                          SizedBox(
                            width: dynamicWidth * 0.2,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  prefixIcon: Icon(Icons.search,
                                      color: Colors.grey[400]),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: DataTable(
                          headingRowHeight: 40,
                          dataRowHeight: 60,
                          columnSpacing: 30,
                          horizontalMargin: 20,
                          columns: const [
                            DataColumn(
                              label: Text(
                                'ID',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'D.O.D',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Action',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            controller.issueTagmodel!.data!.list!.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(controller
                                    .issueTagmodel!.data!.list![index].id
                                    .toString())),
                                DataCell(Text(controller.issueTagmodel!.data!
                                    .list![index].dateofDetection
                                    .toString())),
                                DataCell(
                                  Text(
                                    controller.issueTagmodel!.data!.list![index]
                                                .fTagStatus
                                                .toString()
                                                .split('.')
                                                .last ==
                                            'RED'
                                        ? 'Expired'
                                        : 'Open  ',
                                    style: TextStyle(
                                      color: controller.issueTagmodel!.data!
                                                  .list![index].fTagStatus
                                                  .toString()
                                                  .split('.')
                                                  .last ==
                                              'RED'
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  PopupMenuButton<String>(
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                    onSelected: (String result) {
                                      if (result == 'edit') {
                                        // Handle edit action
                                      } else if (result == 'delete') {
                                        // Handle delete action
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'Delete Confirmation'),
                                            content: const Text(
                                                'Are you sure you want to delete this ID?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'No'),
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () => controller
                                                    .deleteTag(controller
                                                        .issueTagmodel!
                                                        .data!
                                                        .list![index]
                                                        .id!),
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(Icons.menu),
                                      ),
                                    ),
                                    offset: const Offset(0, 35),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )),
                  ],
                ),
          // floatingActionButton: Stack(
          //   children: [
          //     Positioned(
          //       bottom: 9,
          //       left: 30.0,
          //       child: FloatingActionButton.extended(
          //         backgroundColor: DynamicColor.primary,
          //         onPressed: () {},
          //         label: const Text('Mark Tags'),
          //         icon: const Icon(Icons.add),
          //       ),
          //     ),
          //     Positioned(
          //       right: 1.0,
          //       bottom: 9,
          //       child: FloatingActionButton(
          //         backgroundColor: DynamicColor.primary,
          //         onPressed: () => Get.to(const TagCreateScreen()),
          //         child: const Icon(Icons.add),
          //       ),
          //     ),
          //   ],
          // ),
          // FloatingActionButton(
          //     onPressed: () => Get.to(const TagCreateScreen()),
          //     backgroundColor: const Color(0xff003399),
          //     child: const Icon(Icons.add)),
        );
      }),
    );
  }
}
