import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


String getFormattedDateTime(DateTime? dateTime)  {
  if(dateTime == null) return '';
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  return dateFormat.format(dateTime.toLocal());
}

String getFormattedDate(DateTime? dateTime)  {
  if(dateTime == null) return '';
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  return dateFormat.format(dateTime.toLocal());
}

String getFormattedTime(DateTime? dateTime)  {
  if(dateTime == null) return '';
  DateFormat dateFormat = DateFormat("HH:mm");
  return dateFormat.format(dateTime.toLocal());
}

String getCurrencyFormat(int? number)
{
  if(number == null) return '';
  var currencyFormatter = NumberFormat("#,##0", "en_US");
  return currencyFormatter.format(number);
}