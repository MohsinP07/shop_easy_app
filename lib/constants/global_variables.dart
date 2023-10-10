import 'package:flutter/material.dart';

String uri = 'http://192.168.1.207:3000';

class GlobalVariables {
  // COLORS
  static LinearGradient appBarGradient = LinearGradient(
    colors: [Colors.lightBlue.shade300, Colors.teal.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const secondaryColor = Color.fromARGB(255, 76, 168, 196);
  static const secondaryColorCollab = Color(0xFF0CE6DF);
  static const secondaryColorLight = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 9, 158, 221);
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mob_cat.png',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/ess_cat.png',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/app_cat.png',
    },
    {
      'title': 'Books',
      'image': 'assets/images/book_cat.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion_cat.png',
    },
  ];
}
