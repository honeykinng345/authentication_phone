import 'package:geekfleet/modals/myTicketListModal.dart';
import 'package:geekfleet/repo/repo.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _repository = Repository();
  final _ticketFetcher = PublishSubject<List<MyTicketListModal>>();

  Observable<List<MyTicketListModal>> get allTickets => _ticketFetcher.stream;

  fetchAllTickets() async {
    List<MyTicketListModal> items = await _repository.fetchAllTickets();
    _ticketFetcher.sink.add(items);
  }

  dispose() {
    _ticketFetcher.close();
  }
}

final bloc = DataBloc();
