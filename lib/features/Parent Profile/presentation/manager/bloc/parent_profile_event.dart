part of 'parent_profile_bloc.dart';

/// Base event for the ParentProfileBloc.
abstract class ParentProfileEvent extends Equatable {
  const ParentProfileEvent();

  @override
  List<Object> get props => [];
}

/// Dispatched to fetch the currently authenticated parent’s profile.
class FetchParentProfile extends ParentProfileEvent {
  const FetchParentProfile();
}
