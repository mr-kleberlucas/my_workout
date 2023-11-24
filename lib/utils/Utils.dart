 class utils {
  static String getWeekDayName(int day){
    Map<int, String> weekDayMap = {
      1: 'Seg',
      2: 'Ter',
      3: 'Qua',
      4: 'Qui',
      5: 'Sex',
      6: 'Sab',
      7: 'Dom',
    };
    return weekDayMap[day].toString();
  }
}
