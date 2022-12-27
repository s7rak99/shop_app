import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/state.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/style/color.dart';

import '../../../model/search_model.dart';
import '../../../shared/component/constant.dart';


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          label: 'Search',
                          prefixIcon: Icons.search,
                          onSubmit: (value) {
                            SearchCubit.get(context).search(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter text to Search';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (state is SearchLoadingStates)
                          LinearProgressIndicator(),
                        if (state is SearchSuccessStates)
                          Expanded(
                            child: ListView.separated(
                              
                                itemBuilder: (context, i) {
                                  return buildFavItem(
                                      ShopCubit.get(context)
                                          .favoriteModel!
                                          .data!
                                          .data![i]
                                          .product!,
                                      context);
                                },
                                separatorBuilder: (context, i) {
                                  return Container(
                                    color: Colors.grey,
                                    height: 1.0,
                                  );
                                },
                                itemCount: ShopCubit.get(context)
                                    .favoriteModel!
                                    .data!
                                    .data!
                                    .length),
                          )
                      ],
                    ),
                  ),
                ));
          },
        ));
  }

  Widget buildFavItem(Product model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120,
                height: 120,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      vertical: 3, horizontal: 10.0),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price!.round()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          print(model.id);
                          print(token);
                          ShopCubit.get(context).changeFavorites(model.id!);
                          toast(message: '${model.name}', states: ToastsStates.SUCCESS);


                        },
                        icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                            ShopCubit.get(context).favorite![model.id]!
                                ? defaultColor
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

//
// class SearchScreen extends StatelessWidget {
//   var formKey = GlobalKey<FormState>();
//
//   var searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SearchCubit(),
//       child: BlocConsumer<SearchCubit, SearchStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Scaffold(
//               appBar: AppBar(),
//               body: Form(
//                 key: formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       defaultFormField(
//                           controller: searchController,
//                           label: 'search',
//                           prefixIcon: Icons.search,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'nothing';
//                             }
//                             return null;
//                           },
//                           type: TextInputType.text,
//                           onSubmit: (text) {
//                             print('${SearchCubit.get(context)
//                                 .searchModel!
//                                 .data!
//                                 .data!
//                                 .length}');
//                             print('${SearchCubit.get(context).searchModel!.data!.data![0]}');
//
//                             SearchCubit.get(context).search(text!);
//                           }),
//                       const SizedBox(
//                         height: 10.0,
//                       ),
//                       if (state is SearchLoadingStates)
//                         const LinearProgressIndicator(),
//                       ListView.separated(
//                         shrinkWrap: true,
//                           itemBuilder: (context, i) {
//                            // return Container();
//                             return buildListProduct(
//                             
//                                 context, oldPrice: false);
//                           },
//                           separatorBuilder: (context, i) {
//                             return Container(
//                               color: Colors.grey,
//                               height: 1.0,
//                             );
//                           },
//                           itemCount: 1),
//                     ],
//                   ),
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }
