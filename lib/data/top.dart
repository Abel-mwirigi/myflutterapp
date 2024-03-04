import 'package:flutter_application_1/data/globalclass.dart';

List<Money> geter_top() {
  Money fast_food = Money();
  fast_food.time = 'jan 30,2022';
  fast_food.image = 'simcard.jpg';
  fast_food.buy = true;
  fast_food.fee = '- \$ 100';
  fast_food.name = 'smocha';
  Money fast = Money();
  fast.image = 'simcard.jpg';
  fast.time = 'today';
  fast.buy = true;
  fast.name = 'Tomatoes';
  fast.fee = '- \$ 60';

  return [fast_food, fast];
}
