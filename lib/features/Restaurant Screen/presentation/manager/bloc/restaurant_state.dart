import '../../../data/models/menu_item_model.dart';

abstract class RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<MenuItem> menuItems;
  RestaurantLoaded({required this.menuItems});
}

class RestaurantError extends RestaurantState {
  final String errorMessage;

  RestaurantError({required this.errorMessage});
}
