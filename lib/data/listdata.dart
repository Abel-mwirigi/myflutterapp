import 'package:flutter_application_1/data/globalclass.dart';

List<Money> geter() {
  Money mum = Money();
  mum.name = 'mum';
  mum.fee = '650';
  mum.time = 'today';
  mum.image = 'simcard.jpg';
  mum.buy = false;
  Money supper = Money();
  supper.buy = true;
  supper.fee = '150';
  supper.image = 'simcard.jpg';
  supper.name = 'supper';
  supper.time = 'today';
  Money trasfer = Money();
  trasfer.buy = true;
  trasfer.fee = '100';
  trasfer.image = 'simcard.jpg';
  trasfer.name = 'trasfer for sam';
  trasfer.time = 'jan 30,2022';
  return [mum, supper, trasfer];
}
