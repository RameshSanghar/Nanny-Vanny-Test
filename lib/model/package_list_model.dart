class PackageListModel {
  PackageListModel({
    required this.code,
    required this.status,
    required this.message,
    required this.response,
  });

  final String code;
  final String status;
  final String message;
  final List<PackageResponse> response;

  factory PackageListModel.fromJson(Map<String, dynamic> json) {
    return PackageListModel(
      code: json["code"] ?? "",
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      response: json["response"] == null
          ? []
          : List<PackageResponse>.from(
              json["response"]!.map((x) => PackageResponse.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "response": response.map((x) => x?.toJson()).toList(),
      };
}

class PackageResponse {
  PackageResponse({
    required this.title,
    required this.price,
    required this.desc,
  });

  final String title;
  final String price;
  final String desc;

  factory PackageResponse.fromJson(Map<String, dynamic> json) {
    return PackageResponse(
      title: json["title"] ?? "",
      price: json["price"] ?? "",
      desc: json["desc"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "desc": desc,
      };
}
