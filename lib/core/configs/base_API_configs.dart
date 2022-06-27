abstract class BaseAPIConfig {
  Future<Map?> getAPI({String authorization, String url});

  Future<Map?> postAPI(
      {Map<String, String> addOnHeader,
      Map body,
      String url,
      String authorization});

  Future<Map?> patchAPI(
      {Map<String, String> addOnHeader, Map body, String url});

  Future<Map?> putAPI(
      {Map<String, String> addOnHeader, Map body, String url, int id});

  Future<Map?> deleteAPI({
    Map<String, String> addOnHeader,
    Map body,
    String url,
    int id,
    String authorization,
  });
}
