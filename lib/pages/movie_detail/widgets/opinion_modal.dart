import 'package:flutter/material.dart';

class OpinionModal extends StatefulWidget {
  final Function(String) onSave;

  OpinionModal({required this.onSave});

  @override
  _OpinionModalState createState() => _OpinionModalState();
}

class _OpinionModalState extends State<OpinionModal> {
  final TextEditingController _controller = TextEditingController();

  void _submitOpinion() {
    if (_controller.text.isNotEmpty) {
      widget.onSave(_controller.text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Opinião'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Escreva sua opinião'),
        maxLines: 4,
      ),
      actions: [
        TextButton(
          onPressed: _submitOpinion,
          child: Text('Salvar'),
        ),
      ],
    );
  }
}
