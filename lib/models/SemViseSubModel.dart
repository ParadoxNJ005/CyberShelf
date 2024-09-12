class SemViseSubject {
  String? status;
  String? message;
  List<Data>? data;

  SemViseSubject({this.status, this.message, this.data});

  SemViseSubject.fromJson(Map<String, dynamic> json) {
    this.status = json["Status"];
    this.message = json["message"];
    this.data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Status"] = this.status;
    data["message"] = this.message;
    if(this.data != null)
      data["data"] = this.data?.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Data {
  String? id;
  List<String>? itBi;
  List<String>? ece;
  List<String>? it;
  String? yearName;

  Data({this.id, this.itBi, this.ece, this.it, this.yearName});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["_id"];
    this.itBi = json["IT-BI"]==null ? null : List<String>.from(json["IT-BI"]);
    this.ece = json["ECE"]==null ? null : List<String>.from(json["ECE"]);
    this.it = json["IT"]==null ? null : List<String>.from(json["IT"]);
    this.yearName = json["yearName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.id;
    if(this.itBi != null)
      data["IT-BI"] = this.itBi;
    if(this.ece != null)
      data["ECE"] = this.ece;
    if(this.it != null)
      data["IT"] = this.it;
    data["yearName"] = this.yearName;
    return data;
  }
}