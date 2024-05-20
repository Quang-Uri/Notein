import 'package:flutter/material.dart';

class privacy_policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('1. Introduction'),
            _buildSectionContent(
              'We respect the privacy rights of users and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and share your information.',
            ),
            _buildSectionTitle('2. Information We Collect'),
            _buildSectionContent(
              '• Personal information: Includes name, email, phone number, and address.\n'
              '• Non-personal information: Such as information about how you use our website.',
            ),
            _buildSectionTitle('3. How We Use Information'),
            _buildSectionContent(
              'We use your information to:\n'
              '• Provide, maintain, and improve our services.\n'
              '• Send important notifications, such as policy and terms changes.',
            ),
            _buildSectionTitle('4. Sharing Personal Information'),
            _buildSectionContent(
              'We do not sell your personal information to third parties. We only share your information when necessary, such as to provide services or comply with legal requirements.',
            ),
            _buildSectionTitle('5. Information Security'),
            _buildSectionContent(
              'We implement security measures to protect your information from unauthorized access or alteration.',
            ),
            _buildSectionTitle('6. Your Rights'),
            _buildSectionContent(
              'You have the right to access, modify, and delete your personal information. If you have any questions or concerns about our privacy policy, please contact us.',
            ),
            _buildSectionTitle('7. Changes to Privacy Policy'),
            _buildSectionContent(
              'We may update this Privacy Policy from time to time. We will notify you of any changes through our website or via email.',
            ),
            _buildSectionTitle('8. Contact Us'),
            _buildSectionContent(
              'If you have any questions about this Privacy Policy, please contact us at '
              '[your-email@example.com](mailto:your-email@example.com).',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
