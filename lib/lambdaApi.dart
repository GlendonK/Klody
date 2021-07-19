class Lambda {
  final String lambdaUrl = "https://hpcztlgxm0.execute-api.us-east-2.amazonaws.com/default/getlb";
  
}

class LoadBlancer {
static String LBUrl = "hello";

void setLBUrl(String url) {
  LBUrl = url;
}

String getLBUrl() {
  return LBUrl;
}
}