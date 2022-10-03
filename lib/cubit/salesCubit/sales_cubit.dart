// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:training/shared/db.dart';

part 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit() : super(SalesInitial());

  MySql mysql = MySql();

  List listItems = [];
  List shoppingCartList = [];

  void insertDataToDb({
    required String name,
    required double count,
    required double itemCost,
    required double itemSellPrice,
    String? code,
  }) {
    if (name == " " || name.isEmpty) {
      emit(ErrorInseringData(error: "من فضلك أدخل اسم الصنف"));
    } else {
      mysql.insertDate(
        """
        INSERT INTO item(name, count, item_cost, itemSellPrice, code)
Values("$name", $count, $itemCost, $itemSellPrice, "$code")

""",
      ).then((value) {
        print('$value inserted');
        emit(InsertDataToDatabase());
      }).catchError((error) {
        emit(ErrorInseringData(error: error.toString()));
      });
    }
  }

  void readDataFromDatabase() {
    mysql.readDate("SELECT * FROM item ").then((items) {
      listItems = items;
      print(listItems.length);
      emit(GetDataFromDatabase());
    }).catchError((err) {
      print(err);
    });
  }

  List ids = [];
  void idForShoppingCartItems() {
    ids = [];
    for (var item in shoppingCartList) {
      ids.add(item[1]);
    }
    print("ids $ids");
  }

  void addToShoppingCart({required int id}) {
    mysql.readDate("SELECT * FROM item WHERE id = $id ").then((items) {
      // print(
      //     '${item[0]['id']} - ${item[0]['name']} ${item[0]['itemSellPrice']}');

      if (ids.contains(items[0]['id'])) {
        int index = ids.indexOf(items[0]['id']);
        increaseCounter(index);
        emit(
          AlreadyExistInShoppingCart(
            id: items[0]['id'],
          ),
        );
      } else {
        shoppingCartList.add(
            [1, items[0]['id'], items[0]['name'], items[0]['itemSellPrice']]);

        idForShoppingCartItems();
        totalReceipt = 0;
        total();

        emit(AddToShoppingCart());
      }
    }).catchError((err) {
      print(err);
    });
  }

  void deleteItemFromShoppingCart(int index) {
    shoppingCartList.removeAt(index);
    ids.removeAt(index);
    totalReceipt = 0;
    total();

    emit(DeleteItemFromShoppingCart());
  }

  double totalReceipt = 0;
  double total() {
    // totalReceipt = 0;
    for (var item in shoppingCartList) {
      totalReceipt = totalReceipt + (item[0] * item[3]);
    }

    return totalReceipt;
  }

  increaseCounter(int index) {
    shoppingCartList[index][0] += 1;
    totalReceipt = 0;

    total();
    emit(OrderCounter(
      items: shoppingCartList,
      total: totalReceipt,
    ));
  }

  decreaseCounter(int index) {
    if (shoppingCartList[index][0] == 1) {
      shoppingCartList[index][0] = shoppingCartList[index][0];
    } else {
      shoppingCartList[index][0] -= 1;
    }
    totalReceipt = 0;
    total();

    emit(OrderCounter(items: shoppingCartList, total: totalReceipt));
  }

  insertShoppingCartToDatabase({
    required count,
    required String item_name,
    required price,
    required total,
    required int item_id,
    required String invoice,
    required String date,
  }) {
    mysql.insertDate(
        '''
INSERT INTO "daily_sales"(count ,item_name,price, total, invoice, item_id, date)
VALUES($count,"$item_name", $price, $total, '$invoice', $item_id, "$date" )

''').then((value) {
      shoppingCartList = [];
      ids = [];
      total();
      getSalesFromDatabase();
      emit(AddShoppingCartToDatabase());
    }).catchError((error) {});
  }

  List salesList = [];

  getSalesFromDatabase() {
    salesList = [];
    mysql.readDate('SELECT * FROM daily_sales').then((sales) {
      salesList = sales;
      totalSale = 0;
      totalSales();
      emit(GetSalesFromDatabase());
    }).catchError((err) {});
  }

  double totalSale = 0;
  double totalSales() {
    for (var element in salesList) {
      totalSale = totalSale + element['total'];
    }
    emit(TotalSales(total: totalSale));
    return totalSale;
  }
}
