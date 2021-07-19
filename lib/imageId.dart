class ImageId {
  List<String> nameList;

  ImageId({this.nameList});

  ImageId.fromJson(Map<String, dynamic> json) {
    nameList = json['name_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_list'] = this.nameList;
    return data;
  }
}
