import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models/home/product_model.dart';
import 'package:shop_app/shared/components/constants.dart';

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
    return SingleChildScrollView(
      child: Column(
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
         ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1/1.72,
              children: List.generate(
                  model.data!.products.length,
                      (index) => buildGridProduct(model.data!.products[index])
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  image: NetworkImage('${model.image}'),
                  height: 240.0,
                  width: double.infinity,
              ),
              if(model.discount!=0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                       fontSize: 15.0,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    if(model.discount!=0)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough, decorationColor: Colors.cyan
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.favorite_border,
                          size: 20.0,
                        )
                    )
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
