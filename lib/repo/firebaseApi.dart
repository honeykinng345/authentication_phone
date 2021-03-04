import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/utils/firebaseCredentials.dart';

class FirebaseApi {
  Future<List<MyTicketListModal>> fetchTicketList() async {
    List<MyTicketListModal> ticketList;
    var artist = await FirebaseCredentials()
        .firebaseFirestore
        .collection('tickets')
        .where('ticketUserId',
            isEqualTo: FirebaseCredentials().auth.currentUser.uid)
        .get();
    ticketList = mapToList(artist.docs);
    return ticketList;
  }

  fetchUser() async {
    var user = await FirebaseCredentials()
        .firebaseFirestore
        .collection('user')
        .doc(FirebaseCredentials().auth.currentUser.uid)
        .get();
    return user.data();
  }
}
