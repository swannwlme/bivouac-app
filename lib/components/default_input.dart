import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';

class TextFieldColumn extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final int? maxLines;
  final bool enabled;
  final TextStyle? titleStyle;

  const TextFieldColumn({
    required this.controller,
    required this.title,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines,
    this.icon,
    this.enabled = true,
    this.titleStyle,
    super.key
  });

  @override
  State<TextFieldColumn> createState() => _TextFieldColumnState();
}

class _TextFieldColumnState extends State<TextFieldColumn> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: widget.titleStyle ??  const TextStyle(
              fontSize: 16,
              letterSpacing: 0,
              color: Colpal.grey
            ),
          ),
        ),

        verticalSpacer(7),

        TextFormField(
          controller: widget.controller,
        
          enabled: widget.enabled,
        
          obscureText: widget.isPassword ? isObscure : false,
        
          style: const TextStyle(fontSize: 17, letterSpacing: 0),
        
          cursorColor: Colpal.black,
          cursorHeight: 20,
        
          maxLines: widget.maxLines ?? 1,
        
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        
            hintText: widget.hintText,
        
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        
            filled: true,
            fillColor: Colpal.lightGrey,
        
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
        
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colpal.green, width: 2),
            ),
        
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
        
            suffixIcon: widget.isPassword ? IconButton(
                onPressed: (){
                  setState(() {
                    isObscure=!isObscure;
                  });
                },
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, size: 20,)
            ) : null,
          ),
          validator: widget.validator,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          keyboardType: widget.keyboardType,
        ),
      ],
    );
  }
}
