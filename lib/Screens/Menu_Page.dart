import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import 'Quang/archive_Page.dart';
import 'Quang/feedback_Page.dart';
import 'Quang/recycle_Page.dart';
import 'Quang/setting_Page.dart';
import 'Quang/widget_Page.dart';

class Menu_Page extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _userEmail;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                leading: Image.asset('assets/images/google.png',
                    width: 26.0, height: 26.0),
                title: Text(
                  userEmail ?? 'Backup & Restore',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Sign in and synchronize your data'),
                trailing: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(0.25),
                    child: Icon(Icons.cached, color: Colors.black),
                  ),
                ),
                onTap: () {
                  _signInWithGoogle(context);
                },
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                      leading: Icon(Icons.delete, color: Colors.blue),
                      title: Text('Recycle bin'),
                      subtitle: Text('0 mục'),
                      onTap: () {
                        // Xử lý khi nhấn vào Thùng rác
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => recycle_Page()),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                      leading: Icon(Icons.archive, color: Colors.blue),
                      title: Text('Archive'),
                      subtitle: Text('0 mục'),
                      onTap: () {
                        // Xử lý khi nhấn vào Lưu trữ
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => archive_Page()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                leading: Icon(Icons.sms),
                title: Text('Feedback or suggestion'),
                onTap: () {
                  // Xử lý khi nhấn vào Góp ý
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => feedback_Page()),
                  );
                },
              ),
            ),
            SizedBox(height: 8.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                subtitle: Text('Security/Your personal preference'),
                onTap: () {
                  // Xử lý khi nhấn vào Cài đặt
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setting_Page()),
                  );
                },
              ),
            ),
            SizedBox(height: 8.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                leading: Icon(Icons.link),
                title: Text('Widget'),
                subtitle: Text('Sticky notes/Quick access toolbar'),
                onTap: () {
                  // Xử lý khi nhấn vào Tiện ích
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => widget_Page()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            '908261622512-6he0q87dr77dtelmhtlnao7ahpe5hegb.apps.googleusercontent.com',
      );

      GoogleSignInAccount? googleSignInAccount;

      if (kIsWeb) {
        googleSignInAccount = await _googleSignIn.signInSilently();
        if (googleSignInAccount == null) {
          googleSignInAccount = await _googleSignIn.signIn();
        }
      } else {
        googleSignInAccount = await _googleSignIn.signIn();
      }

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          // Lấy UID của người dùng
          String uid = user.uid;
          print('User UID: $uid');
          _userEmail = user.email;
          print('User email: $_userEmail');
          // Replace `MyApp()` with the widget you want to navigate to after signing in

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MyApp(),
            ),
          );
        }
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }
}
