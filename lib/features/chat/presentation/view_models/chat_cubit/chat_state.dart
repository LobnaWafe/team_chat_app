part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatSuccess extends ChatState {
 final List<MessageModel>messages;

 ChatSuccess({required this.messages});

}
 
final class ChatError extends ChatState{
  final String errorMsg;

  ChatError({required this.errorMsg});
  
}