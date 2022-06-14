import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase/supabase.dart';

import '../spotmodel/profile.dart';

/// Class that communicates with external apis
class Repository {
  ///
  Repository({
    required SupabaseClient supabaseClient,
    required FlutterSecureStorage localStorage,
  })  : _supabaseClient = supabaseClient,
        _localStorage = localStorage {
    _setAuthListenner();
  }

  final SupabaseClient _supabaseClient;

  final FlutterSecureStorage _localStorage;

  static const _persistantSessionKey = 'supabase_session';
  // static const _termsOfServiceAgreementKey = 'agreed';

  /// In memory cache of profileDetails.
  // @visibleForTesting
  final Map<String, ProfileDetail> profileDetailsCache = {};
  final _profileStreamController =
      BehaviorSubject<Map<String, ProfileDetail>>();



  /// Return userId or null
  String? get userId => _supabaseClient.auth.currentUser?.id;

  /// Completes when auth state is known
  Completer<void> statusKnown = Completer<void>();

  /// Completer that completes once the logged in user's profile has been loaded
  Completer<void> myProfileHasLoaded = Completer<void>();


  /// The user's profile
  Profile? get myProfile => profileDetailsCache[userId ?? ''];


  /// Whether the user has agreed to terms of service or not
  // Future<bool> get hasAgreedToTermsOfService =>
  //     _localStorage.containsKey(key: _termsOfServiceAgreementKey);

  /// Returns whether the user has agreeed to the terms of service or not.
  // Future<void> agreedToTermsOfService() =>
  //     _localStorage.write(key: _termsOfServiceAgreementKey, value: 'true');

  /// Returns session string that can be used to restore session.
  Future<void> setSessionString(String sessionString) =>
      _localStorage.write(key: _persistantSessionKey, value: sessionString);

  /// Deletes session. Used when user logs out or recovering session failed.
  Future<void> deleteSession() =>
      _localStorage.delete(key: _persistantSessionKey);

  bool _hasRefreshedSession = false;

  /// Resets all cache upon identifying the user
  Future<void> _resetCache() async {
    if (userId != null && !_hasRefreshedSession) {
      _hasRefreshedSession = true;
      // profileDetailsCache.clear();
      // _mapVideos.clear();
      // await getMyProfile();
      // // ignore: unawaited_futures
      // getNotifications();
      // _mapVideosStreamConntroller.add(_mapVideos);
      // final searchLocation = await _locationProvider.determinePosition();
      // await getVideosFromLocation(searchLocation);
    }
  }

  ///
  void _setAuthListenner() {
    _supabaseClient.auth.onAuthStateChange((event, session) {
      _resetCache();
    });
  }

  ///
  /// Recovers session stored inn device's storage.
  Future<void> recoverSession() async {
    final jsonStr = await _localStorage.read(key: _persistantSessionKey);
    if (jsonStr == null) {
      await deleteSession();
      if (!statusKnown.isCompleted) {
        statusKnown.complete();
      }
      return null;
    }

    final res = await _supabaseClient.auth.recoverSession(jsonStr);
    final error = res.error;
    if (error != null) {
      await deleteSession();
      if (!statusKnown.isCompleted) {
        statusKnown.complete();
      }
      throw PlatformException(code: 'login error', message: error.message);
    }
    final session = res.data;
    if (session == null) {
      await deleteSession();
      if (!statusKnown.isCompleted) {
        statusKnown.complete();
      }
      return;
      // return null;
    }

    await setSessionString(session.persistSessionString);
    await _resetCache();
  }

  

  Future<String> signUp({
    // will get from ui through textfield 
    required String email,
    required String password,
  }) async {
    final res = await _supabaseClient.auth.signUp(email, password);
    final error = res.error;
    if (error != null) {
      throw PlatformException(code: 'signup error', message: error.message);
    }
    // await _analytics.logSignUp(signUpMethod: 'email');
    return res.data!.persistSessionString;
  }

  /// Returns Persist Session String
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final res =
        await _supabaseClient.auth.signIn(email: email, password: password);
    final error = res.error;
    if (error != null) {
      throw PlatformException(code: 'login error', message: error.message);
    }
    // await _analytics.logLogin(loginMethod: 'email');
    return res.data!.persistSessionString;
  }


  
}






/// Inserts a new row in `videos` table on Supabase.
// Future<void> saveVideo(Video creatingVideo) async {
//   final res = await _supabaseClient
//       .from('videos')
//       .insert([creatingVideo.toMap()]).execute();
//   final error = res.error;
//   if (error != null) {
//     throw PlatformException(
//       code: error.code ?? 'saveVideo',
//       message: error.message,
//     );
//   }
//   final data = res.data;
//   final createdVideo = creatingVideo.updateId(id: data[0]['id'] as String);
//   _mapVideos.add(createdVideo);
//   _mapVideosStreamConntroller.sink.add(_mapVideos);
//   await _analytics.logEvent(name: 'post_video');
// }
