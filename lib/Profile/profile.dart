import 'dart:io';
import 'package:ShiftStart/HomeScreen/menuScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? selectedGender = 'Male';
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // الحصول على الثيم الحالي
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(theme),
            const SizedBox(height: 20),
            _buildProfileForm(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.primaryColorLight,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(child: IconButton(onPressed: (){
  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MenuScreen(
                     
                    )));
          }, icon:Icon(Icons.arrow_back))),
          Positioned(
            right: 0,
            top: 26,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.share_outlined, color: Colors.white),
                  onPressed: () {
                    // Action for share button
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings_outlined, color: Colors.white),
                  onPressed: () {
                    // Action for settings button
                  },
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? Icon(Icons.person, size: 40, color: Colors.grey)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  "Ibrahim Sa",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Damascus, SY",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('Change Image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildTextField("Fullname", "Ibrahim Sa", nameController),
          const SizedBox(height: 16),
          buildTextField(
            "Date of birth",
            "13/10/2002",
            null,
            isReadOnly: true,
            suffixIcon: Icons.calendar_today,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text("Gender: "),
              Row(
                children: [
                  Radio<String>(
                    value: "Male",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const Text("Male"),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "Female",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const Text("Female"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          buildTextField("Email address", "ibrahmsa28@gmail.com", emailController),
          const SizedBox(height: 16),
          buildTextField("Phone number", "994 109 259", phoneController, prefixText: "+963"),
          const SizedBox(height: 16),
          buildTextField("Location", "Damascus, Syria", locationController),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Action for save button
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColorDark,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            ),
            child: const Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String label,
    String placeholder,
    TextEditingController? controller, {
    bool isReadOnly = false,
    IconData? suffixIcon,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixText: prefixText,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
     ],
);
}
}
