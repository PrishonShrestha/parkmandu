class SignUpEmailAndPasswordFailure{
  final String message;

  const SignUpEmailAndPasswordFailure([this.message = "An Unknown error occured."]);
  factory SignUpEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password' :
        return const SignUpEmailAndPasswordFailure('Please enter a stronger password.');
      case 'invalid-email' :
        return const SignUpEmailAndPasswordFailure('Invalid email.');
      case 'email-already-in-use' :
        return const SignUpEmailAndPasswordFailure('An account already exists for that email.');
      case 'operation-not-allowed' :
        return const SignUpEmailAndPasswordFailure('Operation is not allowed.');
      case 'user-disabled' :
        return const SignUpEmailAndPasswordFailure('This user has been disabled.');
      default :
        return const SignUpEmailAndPasswordFailure();
    }
  }
}