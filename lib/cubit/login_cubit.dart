
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<String?> {
  LoginCubit() : super(null);
static LoginCubit get(context) => BlocProvider.of(context);
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit("Success");
    } catch (error) {
      emit(error.toString());
    }
  }
}
