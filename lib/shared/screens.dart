import 'package:training/presentation/screens/b2b/b2b_screen.dart';
import 'package:training/presentation/screens/clients/client_screen.dart';
import 'package:training/presentation/screens/products/add_item.dart';
import 'package:training/presentation/screens/products/sales_screen.dart';
import 'package:training/presentation/screens/products/shopping_cart.dart';

import '../presentation/screens/add_invoice/add_invoice.dart';
import '../presentation/screens/products/product_screen.dart';
import '../presentation/screens/reports/reports.dart';

List<List> routing = [
  ["0.png", "Invoice ", const AddInvoice()],
  ["0.png", "Product ", const ProductScreen()],
  ["1.png", "Add items ", AddProducts()],
  ["2.png", "ShoppingCart ", const ShoppingCart()],
  ["3.png", " Sales ", const SalesScreen()],
  ["4.png", " Clients ", const ClientScreen()],
  ["5.png", " Suppliers ", const B2bScreen()],
  ["5.png", " ٌreports ", const ReportsScreen()],
];
