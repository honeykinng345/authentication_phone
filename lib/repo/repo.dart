import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/repo/firebaseApi.dart';

class Repository {
  final firebaseProvider = FirebaseApi();
  Future<List<MyTicketListModal>> fetchAllTickets() => firebaseProvider.fetchTicketList();
}