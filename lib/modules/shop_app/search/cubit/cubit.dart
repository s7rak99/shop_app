import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/state.dart';

import '../../../../shared/component/constant.dart';
import '../../../../shared/network/end_point.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String? text) {
    emit(SearchLoadingStates());

    DioHelper.postData(
      url: SEARCH,
      data: {'text': text},
      token: token,
    ).then((value) {

      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(SearchErrorStates());
    });
  }
}
