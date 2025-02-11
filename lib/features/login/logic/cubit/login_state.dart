abstract class  LoginState{}

class InitialLoginState extends LoginState{}
class OnLoadingRegisterState extends LoginState{}
class RegisterSuccessState extends LoginState{}
class RegisterErrorState extends LoginState{}
class OnLoadingLoginState extends LoginState{}
class LoginSuccessState extends LoginState{}
class LoginErrorState extends LoginState{}