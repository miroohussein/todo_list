import 'package:flutter/material.dart';

Widget defultButton(
        {double width = double.infinity,
        Color color = Colors.brown,
        required Function()? function,
        required String text}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 17.0, color: Colors.white),
        ),
      ),
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String? validate(String? value),
  required String text,
  required IconData icon,
  Function()? onTap,
  bool isPassword = false,
  IconData? suffics,
  bool isClickable = true,
// IconData visibleOass = Icons.videocam_off_outlined,
  Function()? function,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      onFieldSubmitted: (String value) {
        print(value);
      },
// onChanged: (value) {
//   print(value);
// },
      enabled: isClickable,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: Icon(suffics != null ? suffics : null),
          onPressed: function,
        ),
        border: OutlineInputBorder(),
      ),
    );

Widget taskItemBuilder(Map model) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.blueAccent,
          child: Text(
            '${model['id']}',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        SizedBox(
          width: 12.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model['Task']}',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
height: 12.0,
),
            Text(
              '${model['Date']}',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
  ;
}
