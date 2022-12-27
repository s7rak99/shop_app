class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel> data=[];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) { 
      data.add(DataModel.fromJson(element));
    });

  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];


  }
}

// {
// "status": true,
// "message": null,
// "data": {
// "current_page": 1,
// "data": [
// {
// "id": 44,
// "name": "اجهزه الكترونيه",
// "image": "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"
// },
// {
// "id": 43,
// "name": "مكافحة كورونا",
// "image": "https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg"
// },
// {
// "id": 42,
// "name": "رياضة",
// "image": "https://student.valuxapps.com/storage/uploads/categories/16445270619najK.6242655.jpg"
// },
// {
// "id": 40,
// "name": "ادوات الاناره",
// "image": "https://student.valuxapps.com/storage/uploads/categories/16445230161CiW8.Light bulb-amico.png"
// },
// {
// "id": 46,
// "name": "ملابس",
// "image": "https://student.valuxapps.com/storage/uploads/categories/1644527120pTGA7.clothes.png"
// }
// ],
// "first_page_url": "https://student.valuxapps.com/api/categories?page=1",
// "from": 1,
// "last_page": 1,
// "last_page_url": "https://student.valuxapps.com/api/categories?page=1",
// "next_page_url": null,
// "path": "https://student.valuxapps.com/api/categories",
// "per_page": 35,
// "prev_page_url": null,
// "to": 5,
// "total": 5
// }
// }
