///Утилита для обработки ошибок
class ExceptionUtils {
  //Получение очищенной ошибки, в данном случае без приписки "Exception:"
  static String clearMessage(Object error) {
    return error.toString().replaceFirst('Exception:', '');
  }
}
