import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';

class FirebaseApi {
  Future<List<MyTicketListModal>> fetchTicketList() async {
    List<MyTicketListModal> ticketList;
    var artist = await FirebaseCredentials()
        .firestore
        .collection('tickets')
        .where(FirebaseCredentials().auth.currentUser.uid)
        .get();
    ticketList = mapToList(artist.docs);
    return ticketList;
  }
}
