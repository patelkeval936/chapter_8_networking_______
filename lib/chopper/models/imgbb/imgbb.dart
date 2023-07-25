// To parse this JSON data, do
//
//     final imgbb = imgbbFromJson(jsonString);

import 'dart:convert';

Imgbb imgbbFromJson(String str) => Imgbb.fromJson(json.decode(str));

String imgbbToJson(Imgbb data) => json.encode(data.toJson());

class Imgbb {
  Data? data;
  bool? success;
  int? status;

  Imgbb({
    this.data,
    this.success,
    this.status,
  });

  factory Imgbb.fromJson(Map<String, dynamic> json) => Imgbb(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "status": status,
      };
}

class Data {
  String? id;
  String? title;
  String? urlViewer;
  String? url;
  String? displayUrl;
  int? width;
  int? height;
  int? size;
  int? time;
  int? expiration;
  Image? image;
  Image? thumb;
  Image? medium;
  String? deleteUrl;

  Data({
    this.id,
    this.title,
    this.urlViewer,
    this.url,
    this.displayUrl,
    this.width,
    this.height,
    this.size,
    this.time,
    this.expiration,
    this.image,
    this.thumb,
    this.medium,
    this.deleteUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        urlViewer: json["url_viewer"],
        url: json["url"],
        displayUrl: json["display_url"],
        width: json["width"],
        height: json["height"],
        size: json["size"],
        time: json["time"],
        expiration: json["expiration"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        thumb: json["thumb"] == null ? null : Image.fromJson(json["thumb"]),
        medium: json["medium"] == null ? null : Image.fromJson(json["medium"]),
        deleteUrl: json["delete_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url_viewer": urlViewer,
        "url": url,
        "display_url": displayUrl,
        "width": width,
        "height": height,
        "size": size,
        "time": time,
        "expiration": expiration,
        "image": image?.toJson(),
        "thumb": thumb?.toJson(),
        "medium": medium?.toJson(),
        "delete_url": deleteUrl,
      };
}

class Image {
  String? filename;
  String? name;
  String? mime;
  String? extension;
  String? url;

  Image({
    this.filename,
    this.name,
    this.mime,
    this.extension,
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        filename: json["filename"],
        name: json["name"],
        mime: json["mime"],
        extension: json["extension"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "name": name,
        "mime": mime,
        "extension": extension,
        "url": url,
      };
}
