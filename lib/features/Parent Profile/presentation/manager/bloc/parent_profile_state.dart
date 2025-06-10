part of 'parent_profile_bloc.dart';


abstract class ParentProfileState extends Equatable {
  const ParentProfileState();

  @override
  List<Object?> get props => [];
}

class ParentProfileInitial extends ParentProfileState {}

class ParentProfileLoading extends ParentProfileState {}

class ParentProfileLoaded extends ParentProfileState {
  final Profile profile;

  const ParentProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ParentProfileError extends ParentProfileState {
   final String message;

  const ParentProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
