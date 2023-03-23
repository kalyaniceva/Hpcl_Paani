class HpclData {
  String marketID;
  String outletID;
  String petrolBrand;
  String petrolOffered;
  String dieselBrand;
  String dieselOffered;
  String district;
  String clientID;
  String stationName;
  String salesArea;
  String primaryRoad;
  String highwayType;
  String city;
  String lotFront;
  String lotDepth;
  String state;
  String typeOperation;
  String latitudeY;
  String longitudeX;
  String? distanceCalculated;

  HpclData({
    required this.marketID,
    required this.outletID,
    required this.petrolBrand,
    required this.petrolOffered,
    required this.dieselBrand,
    required this.dieselOffered,
    required this.district,
    required this.clientID,
    required this.stationName,
    required this.salesArea,
    required this.primaryRoad,
    required this.highwayType,
    required this.city,
    required this.lotFront,
    required this.lotDepth,
    required this.state,
    required this.typeOperation,
    required this.latitudeY,
    required this.longitudeX,
    this.distanceCalculated,
  });
  factory HpclData.fromJson(Map<String, dynamic> json) => HpclData(
      marketID: json['marketID'],
      outletID: json['outletID'],
      petrolBrand: json['petrolBrand'],
      petrolOffered: json['petrolOffered'],
      dieselBrand: json['dieselBrand'],
      dieselOffered: json['dieselOffered'],
      district: json['district'],
      clientID: json['clientID'],
      stationName: json['stationName'],
      salesArea: json['salesArea'],
      primaryRoad: json['primaryRoad'],
      highwayType: json['highwayType'],
      city: json['city'],
      lotFront: json['lotFront'],
      lotDepth: json['lotDepth'],
      state: json['state'],
      typeOperation: json['typeOperation'],
      latitudeY: json['latitudeY'],
      longitudeX: json['longitudeX']);

  Map<String, dynamic> toJson() => {
        "marketID": marketID,
        "outletID": outletID,
        "petrolBrand": petrolBrand,
        "petrolOffered": petrolOffered,
        "dieselBrand": dieselBrand,
        "dieselOffered": dieselOffered,
        "district": district,
        "clientID": clientID,
        "stationName": stationName,
        "salesArea": salesArea,
        "primaryRoad": primaryRoad,
        "highwayType": highwayType,
        "city": city,
        "lotFront": lotFront,
        "lotDepth": lotDepth,
        "state": state,
        "typeOperation": typeOperation,
        "latitudeY": latitudeY,
        "longitudeX": longitudeX,
        "distanceCalculated": distanceCalculated
      };
}
