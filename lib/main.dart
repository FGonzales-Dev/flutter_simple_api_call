import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'employee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Data Fetcher',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Employee Data Fetcher'),
        ),
        body: const Center(
          child: FetchDataButton(),
        ),
      ),
    );
  }
}

class FetchDataButton extends StatelessWidget {
  const FetchDataButton({super.key});

  Future<void> fetchEmployeeData() async {
    final response = await http.get(
      Uri.parse('https://dummy.restapiexample.com/api/v1/employees'),
    );

    if (response.statusCode == 200) {
      List<dynamic> employeesJson = json.decode(response.body)['data'];
      List<Employee> employees =
          employeesJson.map((json) => Employee.fromJson(json)).toList();

      for (var employee in employees) {
        print('Employee Name: ${employee.employeeName}');
        print('Employee Salary: ${employee.employeeSalary}');
        print('Employee Age: ${employee.employeeAge}');
        print('Profile Image: ${employee.profileImage}');
        print('---');
      }
    } else {
      throw Exception('Failed to load employee data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        fetchEmployeeData();
      },
      child: const Text('Fetch Employee Data'),
    );
  }
}
