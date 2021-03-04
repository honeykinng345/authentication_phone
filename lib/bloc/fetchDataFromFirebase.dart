import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/modals/userDataModal.dart';
import 'package:geekfleet/repo/repo.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _repository = Repository();
  final _ticketFetcher = PublishSubject<List<MyTicketListModal>>();
  final _userFetcher = PublishSubject<UserDataModal>();

  Observable<List<MyTicketListModal>> get allTickets => _ticketFetcher.stream;

  Observable<UserDataModal> get userData => _userFetcher.stream;

  fetchAllTickets() async {
    List<MyTicketListModal> items = await _repository.fetchAllTickets();
    _ticketFetcher.sink.add(items);
  }

  fetchUserData() async {
    UserDataModal user = await _repository.fetchUserData();
    _userFetcher.sink.add(user);
  }

  dispose() {
    _ticketFetcher.close();
    _userFetcher.close();
  }
}

final bloc = DataBloc();
