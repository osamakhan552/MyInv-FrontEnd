import 'package:flutter/material.dart';
import 'package:wppl/src/components/form/api_dropdown.dart';
import '../../components/appbar.dart';
import '../../components/form/button.dart';
import '../../components/form/textfield.dart';
import '../../models/employee_model.dart';

final employeeModel = EmployeeModel();

class EmployeeForm extends StatelessWidget {
  EmployeeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Employee Entry Table",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                runSpacing: 10.0,
                spacing: 20.0,
                children: [
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Employee CB ID",
                        onChange: (value) {
                          employeeModel.empCbid = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "First Name",
                        onChange: (value) {
                          employeeModel.empFname = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Last Name",
                        onChange: (value) {
                          employeeModel.empLname = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: RolesDropDown(onChange: (value) {
                      employeeModel.roleId = value?.roleId;
                    }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Phone Number",
                        onChange: (value) {
                          employeeModel.empPhone = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Official Email ID",
                        onChange: (value) {
                          employeeModel.email = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Username",
                        onChange: (value) {
                          employeeModel.username = value;
                        }),
                  ),
                  SizedBox(
                    width: 400,
                    child: FormTextField(
                        text: "Password",
                        onChange: (value) {
                          employeeModel.password = value;
                        }),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FormButton(
                      text: "Confirm",
                      color: Colors.green,
                      onPressed: () async {
                        await employeeModel.post();
                      }),
                  // FormButton(
                  //     text: "Reset",
                  //     color: kPrimaryColor,
                  //     onPressed: () {
                  //       print("Reset pressed");
                  //     }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
