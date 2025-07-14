import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/get_child_service.dart';
import '../../../providers/data_provider.dart';
import '../../widget/serivce_doc_picker_widget.dart';

class ServiceDocWidget extends StatelessWidget {
  const ServiceDocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DataProvider>();
    ChildServiceModel? item = provider.customerChildSer;
    List<Document> documents = item?.documents ?? [];
    if (documents.isEmpty) {
      return const SizedBox.shrink();
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: documents.length,
      itemBuilder: (context, index) {
        Document doc = documents[index];
        return ServiceDocPickerWidget(item: doc);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
