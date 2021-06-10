import 'package:flutter/material.dart';
import 'package:test_signup/utilities/validatorsStock.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class StockRegForm extends StatefulWidget {
  const StockRegForm({Key? key}) : super(key: key);

  @override
  _StockRegFormState createState() => _StockRegFormState();
}

enum Gender { male, female }

class _StockRegFormState extends State<StockRegForm> {
  final formKey = new GlobalKey<FormState>();
  String _email = "",
      _password = "",
      _confirmPassword = "",
      _fname = "",
      _lname = "",
      _phone = "",
      _dob = "";
  Gender _gender = Gender.male;
  bool _terms = false;
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      validator: validateEmail,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => _email = value!,
    );
    final fnameField = TextFormField(
      validator: validateName,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => _fname = value!,
    );
    final lnameField = TextFormField(
      validator: validateName,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => _lname = value!,
    );
    final passwordField = TextFormField(
      obscureText: true,
      validator: validatePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => _password = value,
    );
    final repeatpasswordField = TextFormField(
      obscureText: true,
      validator: (v) {
        if (v == _password)
          return null;
        else
          return "Passwords do not match";
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => _confirmPassword = value!,
    );
    final phoneField = InternationalPhoneNumberInput(
      inputDecoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: validatePhone,
      onInputChanged: (PhoneNumber value) {},
      onSaved: (value) => _phone = value.toString(),
    );
    final dateField = DatePickerDialog(
        initialEntryMode: DatePickerEntryMode.input,
        initialCalendarMode: DatePickerMode.year,
        initialDate: DateTime(DateTime.now().year - 17),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year - 17));
    final terms = Checkbox(
        value: _terms,
        onChanged: (v) {
          setState(() {
            _terms = v!;
          });
        });
    final gender = Column(
      children: [
        RadioListTile<Gender>(
          title: const Text('Male'),
          value: Gender.male,
          groupValue: _gender,
          onChanged: (Gender? value) {
            setState(() {
              _gender = value!;
            });
            print(_gender.index);
          },
        ),
        RadioListTile<Gender>(
          title: const Text('Female'),
          value: Gender.female,
          groupValue: _gender,
          onChanged: (Gender? value) {
            setState(() {
              _gender = value!;
            });
            print(_gender.index);
          },
        ),
      ],
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),
                  Text("Email"),
                  SizedBox(height: 5.0),
                  emailField,
                  SizedBox(height: 15.0),
                  Text("First Name"),
                  SizedBox(height: 10.0),
                  fnameField,
                  SizedBox(height: 15.0),
                  Text("Last name"),
                  SizedBox(height: 10.0),
                  lnameField,
                  SizedBox(height: 20.0),
                  Text("Phone"),
                  SizedBox(height: 10.0),
                  phoneField,
                  SizedBox(height: 20.0),
                  Text("Password"),
                  SizedBox(height: 10.0),
                  passwordField,
                  SizedBox(height: 20.0),
                  Text("Confirm Password"),
                  SizedBox(height: 10.0),
                  repeatpasswordField,
                  SizedBox(height: 20.0),
                  Text("Date of Birth"),
                  SizedBox(height: 10.0),
                  dateField,
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      terms,
                      Text("I accept the terms and conditions"),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text("Gender"),
                  SizedBox(height: 10.0),
                  gender,
                  SizedBox(height: 20.0),
                  SizedBox(height: 5.0),
                  TextButton(
                      onPressed: () {
                        if (_terms) {
                          var a = formKey.currentState!.validate();
                          print(a);
                        }
                      },
                      child: Text("Validate")),
                  TextButton(
                      onPressed: () {
                        formKey.currentState!.reset();
                      },
                      child: Text("Reset"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
