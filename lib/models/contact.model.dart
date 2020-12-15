class Contact {
  final int id;
  final String fullName;
  final int accountName;

  Contact(this.id, this.fullName, this.accountName);

  @override
  String toString() {
    return 'Contact{id: $id, fullName: $fullName, accountName: $accountName}';
  }
}
