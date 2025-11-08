part of 'chats_cubit.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object?> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsWithUsersLoaded extends ChatsState {
  final List<Map<String, dynamic>> chatsWithUsers;

  const ChatsWithUsersLoaded(this.chatsWithUsers);

  @override
  List<Object?> get props => [chatsWithUsers];
}

class ChatsError extends ChatsState {
  final String message;
  const ChatsError(this.message);

  @override
  List<Object?> get props => [message];
}
