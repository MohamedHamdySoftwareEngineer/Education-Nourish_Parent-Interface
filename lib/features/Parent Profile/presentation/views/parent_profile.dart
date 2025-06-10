import 'package:edunourish/features/Parent%20Profile/presentation/manager/bloc/parent_profile_bloc.dart';
import 'package:edunourish/features/Parent%20Profile/presentation/views/widgets/parent_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/api_service.dart';

class ParentProfile extends StatelessWidget {
  const ParentProfile({super.key});

  @override
  Widget build(BuildContext context) {
 
    return BlocProvider(
      create: (context) => ParentProfileBloc(apiService: ApiService())..add(const FetchParentProfile()),
      child: Scaffold(
        body: BlocBuilder<ParentProfileBloc, ParentProfileState>(
          builder: (context, state) {
            if (state is ParentProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ParentProfileLoaded) {
              return  ParentProfileBody(profile:state.profile);
            } else if (state is ParentProfileError) {
              return Center(
                child: Text('Error:${state.message}'),
              );
            }
            return const Center(child: Text("try again later!"));
          },
        ),
      ),
    );
  }
}
