import 'package:flutter/material.dart';
import '../helper/db_helper.dart';
import '../model/database_model.dart';

class HomeDialog extends StatefulWidget {
  final DatabaseModel? dbModel;
  const HomeDialog({Key? key, this.dbModel}) : super(key: key);

  @override
  State<HomeDialog> createState() => _HomeDialogState();
}

class _HomeDialogState extends State<HomeDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.dbModel != null) _controller.text = widget.dbModel!.fullname;
  }

  @override
  Widget build(BuildContext context) {
    _createData() async {
      await DbHelper.createData(DatabaseModel(fullname: _controller.text));
      Navigator.pop(context);
    }

    _deleteData() async {
      await DbHelper.deleteData(widget.dbModel!.id!);
      Navigator.pop(context);
    }

    _updateData() async {
      await DbHelper.updateData(
          DatabaseModel(id: widget.dbModel!.id, fullname: _controller.text));
      Navigator.pop(context);
    }

    return AlertDialog(
      title: Text(widget.dbModel == null ? 'Create Data' : 'Update Data'),
      content: TextField(
        controller: _controller,
      ),
      actions: [
        widget.dbModel == null
            ? TextButton(onPressed: _createData, child: const Text('CREATE'))
            : const SizedBox(),
        widget.dbModel != null
            ? TextButton(onPressed: _updateData, child: const Text('UPDATE'))
            : const SizedBox(),
        widget.dbModel != null
            ? TextButton(onPressed: _deleteData, child: const Text('DELETE'))
            : const SizedBox(),
      ],
    );
  }
}
