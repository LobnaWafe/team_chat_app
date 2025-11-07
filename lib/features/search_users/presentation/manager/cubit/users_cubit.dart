import 'package:bloc/bloc.dart';
import 'package:chats_app/features/search_users/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';


part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  final _usersCollection = FirebaseFirestore.instance.collection('users');

  void listenToUsers() {
    emit(UsersLoading());

    _usersCollection.orderBy('createdAt').snapshots().listen((snapshot) {
      final users = snapshot.docs.map((d) => ChatUser.fromDoc(d)).toList();
      emit(UsersLoaded(users));
    }, onError: (error) {
      emit(UsersError(error.toString()));
    });
  }
}
