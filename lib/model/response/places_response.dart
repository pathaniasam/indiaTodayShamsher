class PlacesResponse {
  String? httpStatus;
  int? httpStatusCode;
  bool? success;
  String? message;
  String? apiName;
  List<PlacesData>? data;

  PlacesResponse(
      {this.httpStatus,
        this.httpStatusCode,
        this.success,
        this.message,
        this.apiName,
        this.data});

  PlacesResponse.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    if (json['data'] != null) {
      data = <PlacesData>[];
      json['data'].forEach((v) {
        data!.add(new PlacesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['httpStatus'] = this.httpStatus;
    data['httpStatusCode'] = this.httpStatusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    data['apiName'] = this.apiName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlacesData {
  String? placeName;
  String? placeId;

  PlacesData({this.placeName, this.placeId});

  PlacesData.fromJson(Map<String, dynamic> json) {
    placeName = json['placeName'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeName'] = this.placeName;
    data['placeId'] = this.placeId;
    return data;
  }
}
