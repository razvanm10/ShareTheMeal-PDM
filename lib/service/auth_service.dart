import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdm_project/model/user.dart';
import 'package:pdm_project/types/user_roles.dart';
import '../repository/database.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  AuthService();

  Future<void> assignRole(UserRoles role) async {
    bool isRoleAssigned = (await getUserRole()) != "dummy role";
    if (isRoleAssigned) {
      await Database.database
          .collection("userRole")
          .doc(getCurrentUserId())
          .update({
        "currentRole": role.name,
      });
    } else {
      await Database.database
          .collection("userRole")
          .doc(getCurrentUserId())
          .set({
        "currentRole": role.name,
      });
    }
  }

  Future<void> signIn() async {
    await _googleSignIn.signOut();
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await account?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken);
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<bool> isSignedIn() async {
    _googleSignIn.signOut();
    return await _googleSignIn.isSignedIn();
  }

  Future<String?> getUserRole() async {
    final docRef =
        Database.database.collection("userRole").doc(getCurrentUserId());
    return await docRef.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        return (snapshot.data() as Map<String, dynamic>)["currentRole"];
      } else {
        return "dummy role";
      }
    });
  }

  UserRoles _roleFromString(String role) {
    switch (role) {
      case "Courier":
        {
          return UserRoles.Courier;
        }
      case "Restaurant":
        {
          return UserRoles.Restaurant;
        }
    }
    return UserRoles.Courier;
  }

  Future<UserRecord> currentUserDetails() async {
    bool isUserSignedIn = await isSignedIn();
    String userRole = await getUserRole() ?? "dummy";
    String userId = getCurrentUserId() ?? "dummy";
    return UserRecord(
        id: userId,
        role: _roleFromString(userRole),
        isSignedIn: isUserSignedIn);
  }
}
