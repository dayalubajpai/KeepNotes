abstract class AuthState{}

class AuthInitialState extends AuthState{}
class AuthLoadingState extends AuthState{}
class AuthCodeSendState extends AuthState{}
class AuthCodeVerifyState extends AuthState{}
class AuthLogInState extends AuthState{
   final user;
  AuthLogInState( this.user);
}
class AuthLogOutState extends AuthState{}
class AuthErrorState extends AuthState{
  final error;
  AuthErrorState(this.error);
}