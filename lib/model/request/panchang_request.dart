class PanchangRequest {
  int? day;
  int? month;
  int? year;
  String? placeId;

  PanchangRequest({this.day, this.month, this.year, this.placeId});

  PanchangRequest.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    data['placeId'] = this.placeId;
    return data;
  }
}
