

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app2/provider/detail_restaurant_provider.dart';

import 'package:restaurant_app2/ui/review_screen.dart';
import 'package:restaurant_app2/utils/result_state.dart';

import '../data/api/api_service.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: Lottie.asset('assets/loading.json'));
            } else if (state.state == ResultState.HasData) {
              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      title:
                          Text(state.detailRestaurantResult.restaurant!.name!),
                      flexibleSpace: Stack(
                        children: [
                          Image.network(
                            ApiService.pictureUrl +
                                state.detailRestaurantResult.restaurant!
                                    .pictureId!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.detailRestaurantResult.restaurant!.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.place,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: state.detailRestaurantResult
                                          .restaurant!.city,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ),
                                TextSpan(
                                  text: state
                                      .detailRestaurantResult.restaurant!.rating
                                      .toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "Deskripsi",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        state.detailRestaurantResult.restaurant!.description!,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showBarModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 20,
                                              ),
                                              child: Text(
                                                "Makanan",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ),
                                            Container(
                                              height: 300,
                                              child: ListView.builder(
                                                itemCount: state
                                                    .detailRestaurantResult
                                                    .restaurant!
                                                    .menus!
                                                    .foods!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 16,
                                                    ),
                                                    leading: Icon(
                                                      Icons.food_bank_outlined,
                                                    ),
                                                    title: Text(
                                                      state
                                                          .detailRestaurantResult
                                                          .restaurant!
                                                          .menus!
                                                          .foods![index]
                                                          .name!,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.redAccent,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.food_bank_outlined,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Makanan",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showBarModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 20,
                                              ),
                                              child: Text(
                                                "Minuman",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ),
                                            Container(
                                              height: 300,
                                              child: ListView.builder(
                                                itemCount: state
                                                    .detailRestaurantResult
                                                    .restaurant!
                                                    .menus!
                                                    .drinks!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    contentPadding: const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                    leading: Icon(
                                                      Icons.local_drink_outlined,
                                                    ),
                                                    title: Text(
                                                      state
                                                          .detailRestaurantResult
                                                          .restaurant!
                                                          .menus!
                                                          .drinks![index]
                                                          .name!,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.orange,
                                      Colors.yellow,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.local_drink_outlined,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Minuman",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Review",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          ReviewScreen.routeName,
                          arguments: state.detailRestaurantResult.restaurant!.id,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text(
                          'Tambah Review',
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.detailRestaurantResult.restaurant!
                          .customerReviews!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(20),
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/profile.jpg'),
                          ),
                          title: Text(
                            state.detailRestaurantResult.restaurant!
                                .customerReviews![index].name!,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          subtitle: Text(
                            state.detailRestaurantResult.restaurant!
                                .customerReviews![index].review!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          trailing: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.access_time,
                                    size: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ' +
                                      state.detailRestaurantResult.restaurant!
                                          .customerReviews![index].date!,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
              return Center(
                child: Text(''),
              );
            }
          },
        ),
    );
  }
}
