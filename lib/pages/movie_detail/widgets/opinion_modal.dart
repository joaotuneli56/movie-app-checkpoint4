import 'package:flutter/material.dart';

class OpinionModal extends StatelessWidget {
  final Function(String) onSave;

  const OpinionModal({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController opinionController = TextEditingController();

    return AlertDialog(
      title: const Text('Adicionar Opinião'),
      content: TextField(
        controller: opinionController,
        decoration: const InputDecoration(hintText: 'Digite sua opinião aqui...'),
        maxLines: 5,
      ),
      actions: [
        TextButton(
          onPressed: () {
            onSave(opinionController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
