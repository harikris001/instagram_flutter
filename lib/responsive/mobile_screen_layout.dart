import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobilecreenLayout extends StatefulWidget {
  const MobilecreenLayout({super.key});

  @override
  State<MobilecreenLayout> createState() => _MobilecreenLayoutState();
}

class _MobilecreenLayoutState extends State<MobilecreenLayout> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Mobile Scrren'),
      ),
    );
  }
}
