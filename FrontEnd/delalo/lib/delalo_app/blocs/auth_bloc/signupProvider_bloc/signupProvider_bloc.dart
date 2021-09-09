import 'package:bloc/bloc.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/repository/auth_repository/signupProvider_repository.dart';
import 'package:flutter/material.dart';

part 'signupProvider_state.dart';
part 'signupProvider_event.dart';

class SignupProviderBloc extends Bloc<SignupProviderEvent, SignupProviderState> {
  final SignupProviderRepository signupProviderRepository;
  SignupProviderBloc({required this.signupProviderRepository}) : super(SignupProviderInitial());

  @override
  Stream<SignupProviderState> mapEventToState(SignupProviderEvent event) async* {
    if (event is SignupProviderFormSubmitted) {
      yield SignupProviderLoading();

      try {
        SignupProvider providerToSignup = SignupProvider(
          email: event.email,
          password: event.password,
          phone: event.phone,
          address: event.address,
          firstname: event.firstname,
          lastname: event.lastname,
          role: event.role,
          image: event.image
        );

        await signupProviderRepository.signupProvider(providerToSignup);
        yield SignupProviderSuccess();

      } catch (e) {
        yield SignupProviderFailure(error: e.toString());
      }
    }
  }
}
