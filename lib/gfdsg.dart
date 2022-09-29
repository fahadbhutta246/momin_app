// import 'package:cloud_firestore/cloud_firestore.dart';
//
// FirebaseFirestore db = FirebaseFirestore.instance;
//
// final usersDocumentRef = db.collection("Users").doc("5QIKxwMuNZWJwFcWqkor");
//
// final usersCollectionRef = db.collection("users");
//
// final aLovelaceDocRef = db.doc("users/");
//
// class City {
//   final String? name;
//   final String? state;
//   final String? country;
//   final bool? capital;
//   final int? population;
//   final List<String>? regions;
//
//   City({
//     this.name,
//     this.state,
//     this.country,
//     this.capital,
//     this.population,
//     this.regions,
//   });
//
//   factory City.fromFirestore(
//       DocumentSnapshot<Map<String, dynamic>> snapshot,
//       SnapshotOptions? options,
//       ) {
//     final data = snapshot.data();
//     return City(
//       name: data?['name'],
//       state: data?['state'],
//       country: data?['country'],
//       capital: data?['capital'],
//       population: data?['population'],
//       regions:
//       data?['regions'] is Iterable ? List.from(data?['regions']) : null,
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       if (name != null) "name": name,
//       if (state != null) "state": state,
//       if (country != null) "country": country,
//       if (capital != null) "capital": capital,
//       if (population != null) "population": population,
//       if (regions != null) "regions": regions,
//     };
//   }
// }
//
// final user = <String, dynamic>{
//   "first": "Mux",
//   "last": "peeps",
//   "born": 1997
// };
//
//
// db.collection("users").add(user).then((DocumentReference doc) =>
// print('DocumentSnapshot added with ID: ${doc.id}'));
//
//
// final city = City(
//   name: "Los Angeles",
//   state: "CA",
//   country: "USA",
//   capital: false,
//   population: 5000000,
//   regions: ["west_coast", "social"],
// );
// final docRef = db
//     .collection("cities")
//     .withConverter(
//   fromFirestore: City.fromFirestore,
//   toFirestore: (City city, options) => city.toFirestore(),
// )
//     .doc("LA");
// await docRef.set(city)