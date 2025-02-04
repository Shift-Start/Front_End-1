import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportsAndAnalytics extends StatefulWidget {
  @override
  _ReportsAndAnalyticsState createState() => _ReportsAndAnalyticsState();
}

class _ReportsAndAnalyticsState extends State<ReportsAndAnalytics> {
  String selectedReport = "User Performance";
  String reportContent = "Report details here...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports and Analytics"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 اختيار نوع التقرير
            DropdownButton<String>(
              value: selectedReport,
              onChanged: (String? newValue) {
                setState(() {
                  selectedReport = newValue!;
                  reportContent = "Details of the $selectedReport report...";
                });
              },
              items: <String>[
                "User Performance",
                "Active Teams",
                "Most Used Templates"
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Divider(),
            Text("Report Content:"),
            SizedBox(height: 10),
            Text(reportContent),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _downloadPDFReport,
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text("Download as PDF"),
                ),
                ElevatedButton.icon(
                  onPressed: _downloadExcelReport,
                  icon: Icon(Icons.table_chart),
                  label: Text("Download as Excel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 إنشاء وتحميل تقرير PDF
  void _downloadPDFReport() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              "Report: $selectedReport\n\n$reportContent",
              style: pw.TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/report.pdf");
    await file.writeAsBytes(await pdf.save());

    await Printing.sharePdf(bytes: await pdf.save(), filename: "report.pdf");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF Report saved successfully!")),
    );
  }

  /// 🔹 إنشاء وتحميل تقرير Excel
  void _downloadExcelReport() async {
    var excel = Excel.createExcel();
    var sheet = excel.sheets[excel.sheets.keys.first]!;

    // إضافة البيانات
    sheet.appendRow(
        [TextCellValue("Report Type"), TextCellValue(selectedReport)]);
    sheet.appendRow([TextCellValue('Details'), TextCellValue(reportContent)]);

    // حفظ الملف
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/report.xlsx";
    final file = File(filePath);
    await file.writeAsBytes(excel.encode()!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Excel Report saved at $filePath")),
    );
  }
}
