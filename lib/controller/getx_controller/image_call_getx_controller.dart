import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_api/controller/helper/news_api_helper.dart';
import 'package:news_app_flutter_api/models/getx_model/image_fetching_getx_model.dart';

class ImageControllerGetx extends GetxController {
  ImageModelGetx imageModelGetx =
      ImageModelGetx(imageData: 'https://flagsapi.com/IN/flat/64.png');

  loadImage({required String img}) async {
    imageModelGetx.imageData = 'https://flagsapi.com/$img/flat/64.png';
    update();
  }
}
