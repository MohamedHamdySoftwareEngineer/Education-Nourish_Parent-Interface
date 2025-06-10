import 'package:edunourish/core/utils/api_service.dart';
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Restaurant%20Screen/data/models/menu_item_model.dart';
import 'package:edunourish/features/Restaurant%20Screen/presentation/manager/bloc/restaurant_bloc.dart';
import 'package:edunourish/features/Restaurant%20Screen/presentation/manager/bloc/restaurant_event.dart';
import 'package:edunourish/features/Restaurant%20Screen/presentation/manager/bloc/restaurant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/assets.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen>
    with SingleTickerProviderStateMixin {
  String searchText = '';

  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 7),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    ));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RestaurantBloc(apiService: ApiService())..add(LoadRestaurantEvent()),
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RestaurantError) {
            return Center(child: Text(state.errorMessage));
          }
          final allMeals = (state as RestaurantLoaded).menuItems;
          final filtered = allMeals.where((meal) {
            final q = searchText.toLowerCase();
            return meal.name.toLowerCase().contains(q) ||
                meal.description.toLowerCase().contains(q);
          }).toList();
          return BaseScaffold(
            appBartTitle: 'Food Place',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 10),
                  Expanded(
                    child: filtered.isEmpty
                        ? _buildNoResults()
                        : GridView.builder(
                            itemCount: filtered.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (_, i) {
                              final meal = filtered[i];
                              return SlideTransition(
                                position: _slideAnim,
                                child: _buildMealCard(meal),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xffc4e9ec),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Discover ',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextSpan(
                    text: 'Delicious ',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextSpan(
                    text: 'Meals',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Culinary masterpieces crafted with passion and precision',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xff171d21),
                    fontSize: 14,
                  ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (v) => setState(() => searchText = v),
                decoration: const InputDecoration(
                  hintText: 'Search dishes, healthy food...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildNoResults() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant_menu, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              'No meals found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget _buildMealCard(MenuItem meal) => InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _showMealDetails(meal),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: 
                    Image.network(
                    meal.photo,
                    fit: BoxFit.cover,
                    errorBuilder: (context,error,stackTrace)=>Image.asset(
                      mealImage,
                      fit:BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  meal.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  meal.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );

  void _showMealDetails(MenuItem meal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final h = MediaQuery.of(context).size.height * 0.7;
        return SizedBox(
          height: h,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xff008f99),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          
                          child: Image.network(
                            meal.photo,
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context,error,stackTrace) => Image.asset(
                            mealImage,
                            height: 400,
                            width: double.infinity,
                            fit:BoxFit.cover,),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          meal.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          meal.description,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
