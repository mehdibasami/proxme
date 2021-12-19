class Socks5ProxyModel {
  String? unix;
  String? ip;
  String? port;
  String? country;
  String? ping;

  Socks5ProxyModel({this.unix, this.ip, this.port, this.country, this.ping});

  Socks5ProxyModel.fromJson(Map<String, dynamic> json) {
    if (json["unix"] is String) this.unix = json["unix"];
    if (json["ip"] is String) this.ip = json["ip"];
    if (json["port"] is String) this.port = json["port"];
    if (json["country"] is String) this.country = json["country"];
    if (json["ping"] is String) this.ping = json["ping"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["unix"] = this.unix;
    data["ip"] = this.ip;
    data["port"] = this.port;
    data["country"] = this.country;
    data["ping"] = this.ping;
    return data;
  }
}
