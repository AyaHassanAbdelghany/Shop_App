import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defultTextFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'search',
                      prefix: Icons.search,
                      functionOnChange: (value){
                        SearchCubit.getInstance(context).getSearch(value);
                      },
                      functionValidator: ( value){
                        if(value.isEmpty){
                          return 'enter text to search';
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if(state is ShopSearchLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if(state is ShopSearchSuccessState)
                    Expanded(
                    child: ListView.separated(
                        itemBuilder:(context,index)=> buildProductItem(
                            SearchCubit.getInstance(context).searchModel!.data!.data[index],context,isOldPrice: false),
                        separatorBuilder: (context,index)=>Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        itemCount: SearchCubit.getInstance(context).searchModel!.data!.data.length
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
