import 'package:get/get.dart';

class PageOneController extends GetxController {
  RxInt count = 0.obs;
  void increment() {
    count++;
  }
  void decrement() {
    count--;
  }

  @override
  void onInit() { // like initState in Stateful Widget
    print('PageOneController onInit');
    super.onInit();
  }

  @override
  void onReady() {
    print('PageOneController onReady');
    super.onReady();
  }

  @override
  void onClose() { // when the controller is removed from memory
    print('PageOneController onClose');
    super.onClose();
  }
}