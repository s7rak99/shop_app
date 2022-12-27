import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, i) {
                return buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[i]);
              },
              separatorBuilder: (context, i) {
                return Container(
                  color: Colors.grey,
                  height: 1.0,
                );
              },
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
        },
        listener: (context, state) {});
  }

  Widget buildCatItem(DataModel data) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children:  [
            Image(
              image: NetworkImage(
                  "${data.image}"),
              width: 100,
              height: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${data.name}',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
