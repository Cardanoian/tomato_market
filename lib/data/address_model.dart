/// page : {"total":"1","current":"1","size":"10"}
/// result : {"crs":"EPSG:900913","type":"place","items":[{"id":"AA0010790323","title":"공간정보산업진흥원","category":"정부공공기관 > 정부투자기관 > 미분류","address":{"road":"경기도 성남시 분당구 판교로 242","parcel":"경기도 성남시 분당구 삼평동 624"},"point":{"x":"14148906.416053323","y":"4495379.988284272"}}]}

class AddressModel {
  AddressModel({
    Page? page,
    Result? result,
  }) {
    _page = page;
    _result = result;
  }

  AddressModel.fromJson(dynamic json) {
    _page = json['page'] != null ? Page.fromJson(json['page']) : null;
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  Page? _page;
  Result? _result;

  Page? get page => _page;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_page != null) {
      map['page'] = _page?.toJson();
    }
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }
}

/// crs : "EPSG:900913"
/// type : "place"
/// items : [{"id":"AA0010790323","title":"공간정보산업진흥원","category":"정부공공기관 > 정부투자기관 > 미분류","address":{"road":"경기도 성남시 분당구 판교로 242","parcel":"경기도 성남시 분당구 삼평동 624"},"point":{"x":"14148906.416053323","y":"4495379.988284272"}}]

class Result {
  Result({
    String? crs,
    String? type,
    List<Items>? items,
  }) {
    _crs = crs;
    _type = type;
    _items = items;
  }

  Result.fromJson(dynamic json) {
    _crs = json['crs'];
    _type = json['type'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  String? _crs;
  String? _type;
  List<Items>? _items;

  String? get crs => _crs;
  String? get type => _type;
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['crs'] = _crs;
    map['type'] = _type;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "AA0010790323"
/// title : "공간정보산업진흥원"
/// category : "정부공공기관 > 정부투자기관 > 미분류"
/// address : {"road":"경기도 성남시 분당구 판교로 242","parcel":"경기도 성남시 분당구 삼평동 624"}
/// point : {"x":"14148906.416053323","y":"4495379.988284272"}

class Items {
  Items({
    String? id,
    String? title,
    String? category,
    Address? address,
    Point? point,
  }) {
    _id = id;
    _title = title;
    _category = category;
    _address = address;
    _point = point;
  }

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _category = json['category'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _point = json['point'] != null ? Point.fromJson(json['point']) : null;
  }
  String? _id;
  String? _title;
  String? _category;
  Address? _address;
  Point? _point;

  String? get id => _id;
  String? get title => _title;
  String? get category => _category;
  Address? get address => _address;
  Point? get point => _point;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['category'] = _category;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_point != null) {
      map['point'] = _point?.toJson();
    }
    return map;
  }
}

/// x : "14148906.416053323"
/// y : "4495379.988284272"

class Point {
  Point({
    String? x,
    String? y,
  }) {
    _x = x;
    _y = y;
  }

  Point.fromJson(dynamic json) {
    _x = json['x'];
    _y = json['y'];
  }
  String? _x;
  String? _y;

  String? get x => _x;
  String? get y => _y;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['x'] = _x;
    map['y'] = _y;
    return map;
  }
}

/// road : "경기도 성남시 분당구 판교로 242"
/// parcel : "경기도 성남시 분당구 삼평동 624"

class Address {
  Address({
    String? road,
    String? parcel,
  }) {
    _road = road;
    _parcel = parcel;
  }

  Address.fromJson(dynamic json) {
    _road = json['road'];
    _parcel = json['parcel'];
  }
  String? _road;
  String? _parcel;

  String? get road => _road;
  String? get parcel => _parcel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['road'] = _road;
    map['parcel'] = _parcel;
    return map;
  }
}

/// total : "1"
/// current : "1"
/// size : "10"

class Page {
  Page({
    String? total,
    String? current,
    String? size,
  }) {
    _total = total;
    _current = current;
    _size = size;
  }

  Page.fromJson(dynamic json) {
    _total = json['total'];
    _current = json['current'];
    _size = json['size'];
  }
  String? _total;
  String? _current;
  String? _size;

  String? get total => _total;
  String? get current => _current;
  String? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['current'] = _current;
    map['size'] = _size;
    return map;
  }
}
