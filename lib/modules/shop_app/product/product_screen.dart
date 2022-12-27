import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/style/color.dart';

import '../../../model/categories_model.dart';
import '../../../model/home_model.dart';
import '../../../shared/component/constant.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
      if (state is ShopSuccessChangeFavoritesState) {

      }
    }, builder: (context, state) {
      return ShopCubit.get(context).homeModel != null &&
            ShopCubit.get(context).categoriesModel != null
            ? productBuilder(ShopCubit.get(context).homeModel!,
            ShopCubit.get(context).categoriesModel!, context)
            : const Center(
          child: CircularProgressIndicator(),
        );
    });
  }

  Widget productBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data!.banners
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return buildCategories(categoriesModel.data!.data[i]);
                        },
                        separatorBuilder: (context, i) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: categoriesModel.data!.data.length),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'New Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.4,
                children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProduct(model.data!.products[index], context),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildCategories(DataModel data) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage("${data.image}"),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            width: double.infinity,
            color: Colors.amber,
            child: Text(
              '${data.name}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model, context) {
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
                width: double.infinity,
                height: 180,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      '${model.price.round()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          print(model.id);
                          print(token);
                          // bool v = CacheHelper.getData(key: 'save')??false;
                          // print("thisssssssssssssssss  $v");
                          // String e = CacheHelper.getData(key: 'email')??'';
                          // print("thisssssssssssssssss  $e");
                          // String p = CacheHelper.getData(key: 'password')??'';
                          // print("thisssssssssssssssss  $p");
                          ShopCubit.get(context).changeFavorites(model.id!);
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
    );
  }
}

//
// ShopCubit.get(context).favorite[model.id]!
// ? const Icon(
// Icons.favorite,
// color: Colors.red,
// size: 18,
// )
// : const Icon(
// Icons.favorite_border,
// size: 18,
// ),
