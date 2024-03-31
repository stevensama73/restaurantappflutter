import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/ribbon_shape.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/database_provider.dart';
import 'package:restaurant_app2/provider/restaurant_provider.dart';
import 'package:restaurant_app2/ui/detail_screen.dart';
import 'package:restaurant_app2/ui/search_screen.dart';
import 'package:restaurant_app2/utils/result_state.dart';

class RestaurantListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lynx',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Temukan restoran favoritmu',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment.bottomCenter,
                      child: SearchScreen(),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: IgnorePointer(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari nama,kategori,menu restoran',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(
                        child: Lottie.asset('assets/loading.json'),
                      );
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.restaurantResult.restaurants.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => {
                              state.restaurantId = state.restaurantResult.restaurants[index].id!,
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: DetailScreen(),
                                ),
                              ),
                            },
                            child: Container(
                              height: 180,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 180,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            child: Image.network(
                                              ApiService.pictureUrl +
                                                  state
                                                      .restaurantResult
                                                      .restaurants[index]
                                                      .pictureId!,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: -30,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: 10,
                                                  bottom: 20,
                                                ),
                                                child: ClipPath(
                                                  clipper: ArcClipper(),
                                                  child: Container(
                                                    height: 40,
                                                    width: 100,
                                                    color: Colors.lightBlue.shade900,
                                                    child: Center(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons.star,
                                                                color: Colors.yellow,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: state
                                                                  .restaurantResult
                                                                  .restaurants[index]
                                                                  .rating!
                                                                  .toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .headline6!
                                                                  .copyWith(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 140,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            blurRadius: 10,
                                            offset: Offset(0, 3), // Shadow position
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment(-1, -0.8),
                                            child: Text(
                                              state.restaurantResult
                                                  .restaurants[index].name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(-1, 0.8),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(
                                                      Icons.place,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: state
                                                        .restaurantResult
                                                        .restaurants[index]
                                                        .city!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Consumer<DatabaseProvider>(
                                            builder: (context, database, _) {
                                              return FutureBuilder<bool>(
                                                future: database.isFavorited(state
                                                    .restaurantResult
                                                    .restaurants[index]
                                                    .id!),
                                                builder: (context, snapshot) {
                                                  var isFavorited = snapshot.data ?? false;
                                                  return Align(
                                                    alignment: Alignment(1, 0.8),
                                                    child: isFavorited ?
                                                    IconButton(
                                                      key: Key('unfavorite'),
                                                      icon: Icon(Icons.favorite),
                                                      color: Colors.red,
                                                      onPressed: () => database.removeFavorite(
                                                          state
                                                              .restaurantResult
                                                              .restaurants[index]
                                                              .id!
                                                      ),
                                                    )
                                                    :
                                                    IconButton(
                                                      key: ValueKey('favorite'),
                                                      icon: Icon(Icons.favorite_border),
                                                      color: Colors.black,
                                                      onPressed: () => database.addFavorite(
                                                          state
                                                              .restaurantResult
                                                              .restaurants[index]
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
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
                    } else if (state.state == ResultState.NoData) {
                      return Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/empty.png',
                              fit: BoxFit.cover,
                            ),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.Error) {
                      return Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/offline.png',
                              fit: BoxFit.cover,
                            ),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
