import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? email;
  String? username;
  String? uid;
  String? bio;
  String? photoUrl;
  List<dynamic>? followers;
  List<dynamic>? following;

  User(
      {this.email,
      this.username,
      this.uid,
      this.bio,
      this.photoUrl,
      this.followers,
      this.following});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    uid = json['uid'];
    bio = json['bio'];
    photoUrl = json['photoUrl'];
    followers = json['followers'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['uid'] = uid;
    data['bio'] = bio;
    data['photoUrl'] = photoUrl;
    data['followers'] = followers;
    data['following'] = following;
    return data;
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot["email"],
        username: snapshot["username"],
        uid: snapshot["uid"],
        bio: snapshot["bio"],
        photoUrl: snapshot["photoUrl"],
        followers: snapshot["followers"],
        following: snapshot["following"]);
  }
}