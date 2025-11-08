import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/features/authentication/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final supabase = Supabase.instance.client;
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Firestore

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    emit(AuthLoading());

    try {
      // 1️⃣ التسجيل في Supabase
      final response = await supabase.auth.signUp(email: email, password: password);
      final user = response.user;

      if (user == null) {
        emit(AuthError(message: "This email is already registered."));
        return;
      }

      String imageUrl = 'assets/image/sign_icon.png';

      // 2️⃣ رفع الصورة على Supabase Storage
      if (image != null) {
        final fileName = '${user.id}.jpg';
        await supabase.storage.from('profile_pics').upload(fileName, image);
        imageUrl = supabase.storage.from('profile_pics').getPublicUrl(fileName);
      }

      // 3️⃣ تخزين بيانات المستخدم في Firestore
      await firestore.collection('users').doc(user.id).set({
        'uid': user.id,
        'name': name,
        'email': email,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AuthSuccess(message: "Signup successful!"));
    } on AuthApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        emit(AuthError(message: "user_not_found"));
        return;
      }

      // ✅ اختياري: جلب بيانات المستخدم من Firestore بعد تسجيل الدخول
      final doc = await firestore.collection('users').doc(user.id).get();
      if (!doc.exists) {
        emit(AuthError(message: "User data not found in Firestore."));
        return;
      }

   final userData = UserModel.fromJson(doc.data()!);
     await CacheHelper.saveCustomData(key: "user", value: userData);

      emit(AuthSuccess(message: "Login successful!"));
   
      
    } on AuthApiException catch (e) {
      if (e.message.contains("Invalid login credentials")) {
        emit(AuthError(message: "invalid_credentials"));
      } else {
        emit(AuthError(message: e.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
