class MTProtoProxyModel {
  String? host;
  String? port;
  String? secret;
  String? country;
  String? up;
  String? down;
  String? uptime;
  String? unix;
  String? ping;

  MTProtoProxyModel(
      {this.host, this.port, this.secret, this.country, this.up, this.down, this.uptime, this.unix, this.ping});

  MTProtoProxyModel.fromJson(Map<String, dynamic> json) {
    if (json["host"] is String) this.host = json["host"];
    if (json["port"] is String) this.port = json["port"];
    if (json["secret"] is String) this.secret = json["secret"];
    if (json["country"] is String) this.country = json["country"];
    if (json["up"] is String) this.up = json["up"];
    if (json["down"] is String) this.down = json["down"];
    if (json["uptime"] is String) this.uptime = json["uptime"];
    if (json["unix"] is String) this.unix = json["unix"];
    if (json["ping"] is String) this.ping = json["ping"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["host"] = this.host;
    data["port"] = this.port;
    data["secret"] = this.secret;
    data["country"] = this.country;
    data["up"] = this.up;
    data["down"] = this.down;
    data["uptime"] = this.uptime;
    data["unix"] = this.unix;
    data["ping"] = this.ping;
    return data;
  }
}
