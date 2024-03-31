import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/model/review_restaurant.dart';
import 'package:restaurant_app2/provider/restaurant_provider.dart';
import 'package:restaurant_app2/provider/review_provider.dart';
import 'package:restaurant_app2/ui/detail_screen.dart';

class ReviewScreen extends StatefulWidget {
  static const routeName = '/review_screen';

  final String id;

  ReviewScreen({required this.id});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late TextEditingController controllerID;
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerReview = TextEditingController();

  @override
  void initState() {
    controllerID = TextEditingController(text: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    controllerNama.dispose();
    controllerReview.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ReviewProvider>(
        create: (_) => ReviewProvider(),
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 300,
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/review.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    controller: controllerID,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Consumer<ReviewProvider>(
                    builder: (context, state, _) {
                      return TextField(
                        controller: controllerNama,
                        decoration: state.nama
                            ? InputDecoration(
                                labelText: 'Nama',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : InputDecoration(
                                labelText: 'Nama',
                                errorText: 'Nama harus diisi!',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Consumer<ReviewProvider>(
                    builder: (context, state, _) {
                      return TextField(
                        controller: controllerReview,
                        maxLines: 4,
                        decoration: state.review
                            ? InputDecoration(
                                labelText: 'Review',
                                prefixIcon: Icon(
                                  Icons.comment_sharp,
                                  color: Colors.black,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : InputDecoration(
                                labelText: 'Review',
                                errorText: 'Review harus diisi!',
                                prefixIcon: Icon(
                                  Icons.comment_sharp,
                                  color: Colors.black,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Consumer<ReviewProvider>(
                    builder: (context, state, _) {
                      return Consumer<RestaurantProvider>(
                        builder: (context, restaurant, _) {
                          return TextButton(
                            onPressed: () {
                              ApiService.reviewRestaurant(
                                ReviewRestaurant(
                                    id: controllerID.value.text,
                                    name: controllerNama.value.text,
                                    review: controllerReview.value.text),
                              );
                              state.checkNama(controllerNama.value.text);
                              state.checkReview(controllerReview.value.text);
                              if (state.nama && state.review) {
                                restaurant.restaurantId = controllerID.value.text;
                                Navigator.pushReplacementNamed(
                                    context,
                                    DetailScreen.routeName
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            child: Text(
                              'Submit',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
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
        ),
      ),
    );
  }
}
