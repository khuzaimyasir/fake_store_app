// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../features/home/view/test_page.dart';
// import '../repository/repository.dart';


// /// Class to hold static method related to requiring auth.
// class AuthRequired {
//   /// Method to determine whether the user has
//   /// the right to perform auth required action
//   /// such as posting videos or viewing their own profile.
//   static Future<void> action(BuildContext context,
//       {required void Function() action}) async {
//     final repository = RepositoryProvider.of<Repository>(context);
//     await repository.statusKnown.future;
//     final userId = repository.userId;
//     if (userId == null) {
//       await Navigator.of(context).push(LoginnPage.route());
//       return;
//     }
//     final myProfile = repository.myProfile;
//     if (myProfile == null) {
//       // await Navigator.of(context)
//       //     .push(EditProfilePage.route(isCreatingAccount: true));
//     } else {
//       action();
//     }
//   }
// }
