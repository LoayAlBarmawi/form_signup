import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:test_signup/utilities/validatorsStock.dart';

class FormBuilderRegForm extends StatefulWidget {
  const FormBuilderRegForm({Key? key}) : super(key: key);

  @override
  _FormBuilderRegFormState createState() => _FormBuilderRegFormState();
}

class _FormBuilderRegFormState extends State<FormBuilderRegForm> {
  final _formKey = new GlobalKey<FormBuilderState>();
  String _email = "",
      _password = "",
      _confirmPassword = "",
      _fname = "",
      _lname = "",
      _phone = "",
      _dob = "",
      _gender = "Male";
  bool _terms = false;

  @override
  Widget build(BuildContext context) {
    final emailField = FormBuilderTextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      name: "Email",
      onChanged: (v) {
        _email = v!;
      },
      validator:
          FormBuilderValidators.email(context, errorText: "Invalid Email"),
    );
    final fnameField = FormBuilderTextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      name: "fname",
      onSaved: (v) {
        if (v == null) {
          _fname = "";
        } else
          _fname = v;
      },
      validator: validateName,
    );
    final lnameField = FormBuilderTextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      name: "lname",
      onSaved: (v) {
        if (v == null) {
          _fname = "";
        } else
          _fname = v;
      },
      validator: validateName,
    );
    final phoneField = InternationalPhoneNumberInput(
      inputDecoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: validatePhone,
      onInputChanged: (PhoneNumber value) {},
      onSaved: (value) => _phone = value.toString(),
    );
    final passwordField = FormBuilderTextField(
      name: "Password",
      obscureText: true,
      validator: validatePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => _password = value!,
    );
    final repeatpasswordField = FormBuilderTextField(
        name: "ConfirmPassword",
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
        onSaved: (v) {
          if (v == null) {
            _confirmPassword = "";
          } else
            _confirmPassword = v;
        });
    final dateField = FormBuilderDateTimePicker(
        name: "Date of Birth",
        initialEntryMode: DatePickerEntryMode.input,
        initialDate: DateTime(DateTime.now().year - 17),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year - 17));
    final terms = FormBuilderCheckbox(
        name: "terms",
        initialValue: false,
        title: Text("I accept the terms and conditions"),
        onChanged: (v) {
          setState(() {
            _terms = v!;
          });
        });
    final gender = FormBuilderRadioGroup(
      initialValue: _gender,
      name: "Gender",
      options: [
        FormBuilderFieldOption(
          value: "Male",
        ),
        FormBuilderFieldOption(value: "Female")
      ],
      onChanged: (v) {
        _gender = v.toString();
      },
    );
    return Material(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
              Text("Gender"),
              SizedBox(height: 10.0),
              gender,
              SizedBox(height: 20.0),
              terms,
              SizedBox(height: 20.0),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate() && _terms) {
                          print(_formKey.currentState!.value.toString());
                        } else {
                          print("validation failed");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
