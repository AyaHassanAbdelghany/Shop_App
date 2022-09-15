import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/home/home_model.dart';

import '../../layout/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {},
      builder:(context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.getInstance(context).homeModel != null ,
            builder:(context) =>buildProduct(ShopCubit.getInstance(context).homeModel) ,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProduct(HomeModel? model){
    return Column(
      children: [
       CarouselSlider(
           items: model!.data!.banners.map((e) =>
             Image(
               image: NetworkImage('${e.image}'),
               width: double.infinity,
               fit: BoxFit.cover,
             ),
           ).toList(),
           options: CarouselOptions(
             height: 250.0,
             autoPlay: true,
             autoPlayInterval: Duration(
               seconds: 3,
             ),
             reverse: false,
             initialPage: 0,
             enableInfiniteScroll: true,
             autoPlayAnimationDuration: Duration(
               seconds: 1,
             ),
             autoPlayCurve: Curves.fastOutSlowIn,
             scrollDirection: Axis.horizontal,
             viewportFraction: 1.0
           )
       )
      ],
    );
  }
}
