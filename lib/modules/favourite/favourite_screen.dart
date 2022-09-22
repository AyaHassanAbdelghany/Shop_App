import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/favourities/data_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state) => ConditionalBuilder(
        condition: ShopCubit.getInstance(context).favouriteModel !=null ,
        builder: (context) =>
          ListView.separated(
            itemBuilder:(context,index)=> buildProductItem(
                ShopCubit.getInstance(context).favouriteModel!.data!.data[index].product,context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            itemCount: ShopCubit.getInstance(context).favouriteModel!.data!.data.length
        ),
        fallback: (context) =>Center(child: CircularProgressIndicator()) ,
      ),
    );
  }

}
