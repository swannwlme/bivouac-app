import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddMemberScreen extends StatefulWidget {
  final void Function(List<String>) updateScreen;
  final List<String>? currentMembers;
  const AddMemberScreen({super.key, required this.updateScreen, this.currentMembers});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {

  TextEditingController memberController = TextEditingController();

  List<String> members = [];

  @override
  void initState() {
    if (widget.currentMembers != null) {
      setState(() {
        members = widget.currentMembers!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              cursorColor: Colors.grey[700],
              decoration: InputDecoration(
                hintText: 'Search for a member',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                fillColor: Colors.grey[300],
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide.none
                ),
              ),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),

            verticalSpacer(30),

            
          ],
        ),
      ),
    );
  }
}