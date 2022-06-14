// ignore_for_file: public_member_api_docs

// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:fake_store_app/features/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:stop_shop/pages/loginn_page.dart';
// import 'package:spot/cubits/notification/notification_cubit.dart';
// import 'package:spot/data_profiders/location_provider.dart';
// import 'package:spot/pages/tab_page.dart';
// import 'package:spot/repositories/repository.dart';
import 'package:supabase/supabase.dart';

// import '../cubits/notification/notification_cubit.dart';
// import '../data_profiders/location_provider.dart';
import '../features/home/view/test_page.dart';
import '../repository/repository.dart';
import 'blockys/bloc/cart_bloc.dart';
// import '../pages/tab_page.dart';
// import '../repositories/repository.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const _supabaseUrl = 'https://qbnlmhaeanhtlfzmtlsd.supabase.co';
  static const _supabaseannonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFibmxtaGFlYW5odGxmem10bHNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDc1MTQ0MDYsImV4cCI6MTk2MzA5MDQwNn0.8InymT21BoCe70dE6OKS7XwleghC3zeIcig6bGPvx28';
  final _supabaseClient = SupabaseClient(_supabaseUrl, _supabaseannonKey);
  // final _analytics = FirebaseAnalytics();
  final _localStorage = const FlutterSecureStorage();
  // final _locationProvider = LocationProvider();
  
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Repository>(
          create: (context) => Repository(
            supabaseClient: _supabaseClient,
            // analytics: _analytics,
            localStorage: _localStorage,
            // locationProvider: _locationProvider,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
            BlocProvider(
            create: (_) => CartBloc()..add(LoadCart()),
          ),
        //   BlocProvider<NotificationCubit>(
        //     create: (context) => NotificationCubit(
        //       repository: RepositoryProvider.of<Repository>(context),
        //     )..loadNotifications(),
        //   )
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Color(0xFFFFFFFF)),
            primaryColor: const Color(0xFFFFFFFF),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFFFFFFF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFFFFFFF)),
              ),
              focusColor: Color(0xFFFFFFFF),
              isDense: true,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(primary: const Color(0xFFFFFFFF)),
            ),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.7),
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          // localizationsDelegates: [
          //   GlobalMaterialLocalizations.delegate,
          // ],
        // navigatorObservers: [
        //     FirebaseAnalyticsObserver(analytics: _analytics),
        //   ],
          home: HomeView(),
        ),
      ),
    );
  }
}
