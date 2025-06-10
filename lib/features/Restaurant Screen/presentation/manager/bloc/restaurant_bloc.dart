import 'package:edunourish/core/utils/api_service.dart';
import 'package:edunourish/features/Restaurant%20Screen/presentation/manager/bloc/restaurant_event.dart';
import 'package:edunourish/features/Restaurant%20Screen/presentation/manager/bloc/restaurant_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final ApiService apiService;

  RestaurantBloc({required this.apiService}) : super(RestaurantLoading()) {
    on<LoadRestaurantEvent>(_onLoadRestaurant);
  }

  Future<void> _onLoadRestaurant(
    LoadRestaurantEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());

    try {
      final menuItems =
          await apiService.fetchMenuItems(endPoint: 'ResturantMenu/view');
      emit(RestaurantLoaded(menuItems: menuItems));
    } catch (e) {
      emit(RestaurantError(errorMessage: e.toString()));
    }
  }
}
