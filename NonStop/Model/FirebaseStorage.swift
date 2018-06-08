////
////  FirebaseStorage.swift
////  NonStop
////
////  Copyright © 2018 Alexandra Klimenko. All rights reserved.
////
//
//import Foundation
//import Firebase
//import FirebaseDatabase
//
//class FirebaseStorage {
//   // FirebaseApp.configure()
//    //Firebase storage
//   
//
//    
//    func readStorage() {
////        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
////            do {
////                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
////                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
////                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
////
////                }
////            } catch {
////
////            }
////        }
//        
//        //let storage = Storage.storage()
//        
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        
//        let array = ref.child("Airports").child("LAX").child("Flight");
//        print("Array");
//        dump(array);
////        for object in array {
////
//////            let flight =
////        }
//        
//
////        let userID = Auth.auth().currentUser?.uid
////        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
////            // Get user value
////            let value = snapshot.value as? NSDictionary
////            let username = value?["username"] as? String ?? ""
////            let user = User(username: username)
////
////            // ...
////        }) { (error) in
////            print(error.localizedDescription)
////        }
//    }
//    
//    //get Flight Time from flight Number
//    func getFlightTime(flightNumber:String) -> String {
//        let flightTime = ""
//        return flightTime
//    }
//    
//    
//    
//}
//
//
