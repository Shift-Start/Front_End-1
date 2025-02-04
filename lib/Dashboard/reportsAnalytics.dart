import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:ShiftStart/Dashboard/themeColor.dart';
import 'package:provider/provider.dart';


class ReportsAndAnalytics extends StatefulWidget {
  @override
  _ReportsAndAnalyticsState createState() => _ReportsAndAnalyticsState();
}

class _ReportsAndAnalyticsState extends State<ReportsAndAnalytics> {
  String selectedReport = "User Performance";
  String reportContent = "Report details here...";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiProviderAdmain>(context);
    bool isDarkMode = themeProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports and Analytics"),
        backgroundColor: isDarkMode ? Colors.black : AppColors.lightButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  اختيار نوع التقرير
            Text("Select Report Type:", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(8),
                
              ),
              child:Card(elevation: 3,
              
              child: Padding(padding: const EdgeInsets.all(12.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text('Select Report Type:',style: TextStyle(fontWeight: FontWeight.bold),),
               DropdownButton<String>(
                value: selectedReport,
                isExpanded: true,
                underline: SizedBox(),
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
           ], ),)),),

            Divider(height: 30),

            //  عرض محتوى التقرير
            Text("Report Content:", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(reportContent, style: const TextStyle(fontSize: 14)),
            ),

            const SizedBox(height: 20),

            //  أزرار تحميل التقرير
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDownloadButton(
                  icon: Icons.picture_as_pdf,
                  label: "Download PDF",
                  color: Colors.red,
                  onPressed: _downloadPDFReport,
                ),
                _buildDownloadButton(
                  icon: Icons.table_chart,
                  label: "Download Excel",
                  color: Colors.blue,
                  onPressed: _downloadExcelReport,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // دالة لإنشاء زر تحميل التقرير
  Widget _buildDownloadButton({required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  ///  إنشاء وتحميل تقرير PDF
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
      const SnackBar(content: Text("PDF Report saved successfully!")),
    );
  }

  ///  إنشاء وتحميل تقرير Excel
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
