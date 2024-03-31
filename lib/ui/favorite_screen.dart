import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/ribbon_shape.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/database_provider.dart';
import 'package:restaurant_app2/provider/restaurant_provider.dart';
import 'package:restaurant_app2/utils/result_state.dart';

import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, database, _) {
          if (database.state == ResultState.HasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: database.favorites.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    return GestureDetector(
                      onTap: () => {
                        state.restaurantId = database.favorites[index].id!,
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
                                            database.favorites[index]
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
                                                        text: database.favorites[index]
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
                                        database.favorites[index].name!,
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
                                              text: database.favorites[index]
                                                  .city!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    FutureBuilder<bool>(
                                      future: database.isFavorited(database.favorites[index].id!),
                                      builder: (context, snapshot) {
                                        var isFavorited = snapshot.data ?? false;
                                        return Align(
                                          alignment: Alignment(1, 0.8),
                                          child: isFavorited ?
                                          IconButton(
                                            icon: Icon(Icons.favorite),
                                            color: Colors.red,
                                            onPressed: () => database.removeFavorite(
                                                database.favorites[index].id!
                                            ),
                                          )
                                          :
                                          IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            color: Colors.black,
                                            onPressed: () => database.addFavorite(
                                                database.favorites[index]
                                            ),
                                          ),
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
              },
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 80),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/restoran.png',
                        fit: BoxFit.cover,
                      ),
                      Text(
                        database.message,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      ),
    );
  }
}
