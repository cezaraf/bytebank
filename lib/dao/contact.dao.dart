import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.model.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSql = 'create table $_tableName ('
      '$_id integer primary key, '
      '$_fullName text not null, '
      '$_accountNumber integer not null )';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _fullName = 'full_name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contactMap = Map();
    contactMap[_fullName] = contact.fullName;
    contactMap[_accountNumber] = contact.accountName;
    return db.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName, orderBy: _fullName);
    return maps.map((map) => Contact(map[_id], map[_fullName], map[_accountNumber])).toList();
  }
}
