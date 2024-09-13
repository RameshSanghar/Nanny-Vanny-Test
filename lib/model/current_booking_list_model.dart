class CurrentBookingListModel {
  CurrentBookingListModel({
    required this.code,
    required this.status,
    required this.message,
    required this.response,
  });

  final String code;
  final String status;
  final String message;
  final List<BookingResponse> response;

  factory CurrentBookingListModel.fromJson(Map<String, dynamic> json) {
    return CurrentBookingListModel(
      code: json["code"] ?? "",
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      response: json["response"] == null
          ? []
          : List<BookingResponse>.from(
              json["response"]!.map((x) => BookingResponse.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "response": response.map((x) => x?.toJson()).toList(),
      };
}

class BookingResponse {
  BookingResponse({
    required this.title,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
  });

  final String title;
  final String fromDate;
  final String fromTime;
  final String toDate;
  final String toTime;

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      title: json["title"] ?? "",
      fromDate: json["from_date"] ?? "",
      fromTime: json["from_time"] ?? "",
      toDate: json["to_date"] ?? "",
      toTime: json["to_time"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "from_date": fromDate,
        "from_time": fromTime,
        "to_date": toDate,
        "to_time": toTime,
      };
}
