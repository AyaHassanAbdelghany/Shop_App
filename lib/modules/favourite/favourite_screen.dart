import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/favourities/data_model.dart';
import '../../shared/components/constants.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state) => ConditionalBuilder(
        condition: state !is ShopFavouriteLoadingState ,
        builder: (context) =>
          ListView.separated(
            itemBuilder:(context,index)=> buildFavouriteItem(ShopCubit.getInstance(context).favouriteModel!.data!.data[index],context),
            separatorBuilder: (context,index)=>Container(),
            itemCount: ShopCubit.getInstance(context).favouriteModel!.data!.data.length
        ),
        fallback: (context) =>Center(child: CircularProgressIndicator()) ,
      ),
    );
  }

  Widget buildFavouriteItem(DataModel model,BuildContext context) =>Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage('${model.product!.image}'),
            height: 240.0,
            width: double.infinity,
          ),
          if(model.product!.discount!=0)
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
              '${model.product!.name}',
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
                  '${model.product!.price}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                if(model.product!.discount!=0)
                  Text(
                    '${model.product!.oldPrice}',
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
  );
}
