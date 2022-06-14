import 'dart:async';

import 'package:fake_store_app/features/home/view/cart_page.dart';
import 'package:fake_store_app/features/home/view/home_view.dart';
import 'package:fake_store_app/features/home/view/test_page.dart';
import 'package:fake_store_app/supabasestart/login_page.dart';
// import 'package:fake_store_app/supabasestart/account_page.dart';

import 'package:fake_store_app/supabasestart/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'dart:async';
import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
// import 'package:spot/app/app.dart';
// import 'package:spot/app/app_bloc_observer.dart';

import 'app/app.dart';
// import 'app/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}


