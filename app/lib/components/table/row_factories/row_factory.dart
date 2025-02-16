import 'package:flutter/material.dart';

abstract class RowFactory<T> {
  DataRow create(BuildContext context, T data);
}
