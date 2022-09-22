import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/categories/category_model.dart';
import 'package:shop_app/models/categories/data_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models/home/product_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../layout/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavouriteSuccessState ){
          if(!state.changeFavouriteModel.status){
            defultToast(message: state.changeFavouriteModel.message!, state: ToastStates.ERROR);
          }
        }
        else if(state is ShopChangeFavouriteErrorState ){
            defultToast(message: 'Can\'t add to favourite', state: ToastStates.ERROR);
        }
      },
      builder:(context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.getInstance(context).homeModel != null && ShopCubit.getInstance(context).categoryModel != null ,
            builder:(context) =>buildProduct(ShopCubit.getInstance(context).homeModel,ShopCubit.getInstance(context).categoryModel,context) ,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProduct(HomeModel? homeModel,CategoryModel? categoryModel,BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         CarouselSlider(
             items: homeModel!.data!.banners.map((e) =>
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
                 seconds: 2,
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0
            ),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=> buildCategory(categoryModel.model!.data[index]),
                      separatorBuilder:(context,index)=> SizedBox(width: 8.0),
                      itemCount: categoryModel!.model!.data.length
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
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
                  homeModel.data!.products.length,
                      (index) => buildGridProduct(homeModel.data!.products[index],context)
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model,BuildContext context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                imageUrl: '${model!.image}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                const Icon(Icons.downloading, color: Colors.grey),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 240.0,
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
                    fontSize: 14.0,
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
                    fontSize: 15.0,
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
                        onPressed: (){
                          print("id ${model.id}");
                          ShopCubit.getInstance(context).changeFavourite(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: ShopCubit.getInstance(context).favourites[model.id] !=true ? Colors.grey :primaryColor ,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 18.0,
                          ),
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

  Widget buildCategory(DataModel data) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
              image: NetworkImage('${data.image}'),
              height: 100.0,
              width: 100.0,
             fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0
            ),
            width: 100.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(7.0),
            ) ,
            child: Text(
              '${data.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),

              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
