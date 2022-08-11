class AppConstant {
  static const String APP_NAME = "Food-Store";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "https://foodapp.sawcinema.host/";
  static const String POPULAR_PRODUCT_URI = "api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "api/v1/products/recommended";
  static const String DRINKS_URI = "api/v1/products/drinks";

  static const String UPLOAD_URL = "uploads/";
  //auth endpoint
  static const String REGISTRATION_URI = "api/v1/auth/register";
  static const String SIGN_IN_URI = "api/v1/auth/login";
  static const String USER_INFO_URI = "api/v1/customer/info";
  //Location endpoint
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USERADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';

  static const String TOKEN = "";
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  static const String PHONE = "";
  static const String PASSWORD = "";
}
