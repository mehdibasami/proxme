class ApiUrl {
  //
  static String mtprotoUri = 'https://mtpro.xyz/api/?type=mtproto';
  static String socks5Uri = 'https://mtpro.xyz/api/?type=socks';
  //
  static String finalMTProtoProxy(String host, String port, String secret) {
    return 'tg://proxy?server=' + host + '&port=' + port + '&secret=' + secret;
  }

  static String finalSocks5Proxy(String ip, String port) {
    return 'tg://socks?server=' + ip + '&port=' + port;
  }
}
