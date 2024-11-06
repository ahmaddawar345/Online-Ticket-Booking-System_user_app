import 'package:flutter/cupertino.dart';
import 'package:online_ticket_booking/models/agency_model.dart';

class AgencyController extends ChangeNotifier {
  String? _selectedAgencyId;
  String? _selectedAgencyName;
  TravelAgency? _selectedAgency;

  String? get selectedAgencyId => _selectedAgencyId;
  TravelAgency? get selectedAgency => _selectedAgency;

  selectAgencyId(String id) {
    _selectedAgencyId = id;
  }
  // selectAgencyName(String agencyName) {
  //   _selectedAgencyId = ;
  // }

  selectAgency(TravelAgency agency) {
    _selectedAgency = agency;
    selectAgencyId(agency.id);
    // selectAgencyName(agency.id);
  }
}
