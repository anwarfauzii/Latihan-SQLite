import 'package:flutter/material.dart';

import '../../database/db_helper.dart';
import '../../model/note.dart';

class HomeDialog extends StatefulWidget {
  const HomeDialog({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<HomeDialog> createState() => _HomeDialogState();
}

class _HomeDialogState extends State<HomeDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) _controller.text = widget.note!.content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null ? 'Create Data' : 'Update Data'),
      content: TextField(
        controller: _controller,
      ),
      actions: <Widget>[
        if (widget.note == null)
          TextButton(
            onPressed: _createData,
            child: const Text('CREATE'),
          ),
        if (widget.note != null)
          TextButton(
            onPressed: _updateData,
            child: const Text('UPDATE'),
          ),
        if (widget.note != null)
          TextButton(
            onPressed: _deleteData,
            child: const Text('DELETE'),
          ),
      ],
    );
  }

  Future<void> _createData() async {
    await DbHelper.createData(
      Note(
        content: _controller.text,
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _updateData() async {
    await DbHelper.updateData(
      Note(
        id: widget.note!.id,
        content: _controller.text,
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _deleteData() async {
    await DbHelper.deleteData(widget.note!.id!);
    Navigator.pop(context);
  }
}
