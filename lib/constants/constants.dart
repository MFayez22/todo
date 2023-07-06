import '../network/local/cache_helper.dart';

bool isEnglish1 = CacheHelper.getData(key: 'isEnglish') ?? true;

List<String> titleList = isEnglish1 ? [
  'Settings',
  'Home',
  'Task',
  'Notes',
  'Done',
]:[
  'الإعدادات',
  'الصفحة الرئيسية',
  'المهمات',
  'مذكرة',
  'المنجز',
];