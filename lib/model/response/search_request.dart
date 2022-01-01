class SearchRequest {
  String? inputPlace;

  SearchRequest({this.inputPlace});

  SearchRequest.fromJson(Map<String, dynamic> json) {
    inputPlace = json['inputPlace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inputPlace'] = this.inputPlace;
    return data;
  }
}
