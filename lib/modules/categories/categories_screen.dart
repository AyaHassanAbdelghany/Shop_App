import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories/data_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (contex,state) =>
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
            itemBuilder: (contex,index)=>buildItemCategory(ShopCubit.getInstance(context).categoryModel!.model!.data[index]),
            separatorBuilder: (contex,index) =>Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            itemCount: ShopCubit.getInstance(context).categoryModel!.model!.data.length
      ),
          ),
    );
  }

  Widget buildItemCategory(DataModel data) => Row(
    children: [
      CachedNetworkImage(
        imageUrl: '${data!.image}',
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
        const Icon(Icons.downloading, color: Colors.grey),
        fit: BoxFit.cover,
        width: 120.0,
        height: 120.0,
      ),
      SizedBox(
        width: 10.0,
      ),
      Text(
        '${data.name}',
        style: TextStyle(
          fontSize: 24.0,
        ),
        textAlign: TextAlign.center,
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios),
    ],
  );
}
