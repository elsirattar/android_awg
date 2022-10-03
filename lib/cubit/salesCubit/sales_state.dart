// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sales_cubit.dart';

@immutable
abstract class SalesState {}

class SalesInitial extends SalesState {}

class InsertDataToDatabase extends SalesState {}

class ErrorInseringData extends SalesState {
  final String error;
  ErrorInseringData({
    required this.error,
  });
}

class GetDataFromDatabase extends SalesState {}

class AddToShoppingCart extends SalesState {}

// ignore: must_be_immutable
class OrderCounter extends SalesState {
  List items;
  double total;
  OrderCounter({
    required this.items,
    required this.total,
  });
}

// ignore: must_be_immutable
class AlreadyExistInShoppingCart extends SalesState {
  int id;
  AlreadyExistInShoppingCart({
    required this.id,
  });
}

class DeleteItemFromShoppingCart extends SalesState {}

class AddShoppingCartToDatabase extends SalesState {}

class GetSalesFromDatabase extends SalesState {}

// ignore: must_be_immutable
class TotalSales extends SalesState {
  double total;
  TotalSales({
    required this.total,
  });
}
