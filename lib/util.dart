
class Util {

  static String makeImgPath(String imgName, {String width = "w500"}){
    return "https://image.tmdb.org/t/p/$width$imgName";
  }
}
