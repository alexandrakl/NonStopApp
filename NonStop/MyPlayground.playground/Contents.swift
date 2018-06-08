//: Playground - noun: a place where people can play

import UIKit
import Foundation
import Firebase

var str = "Hello, playground"

class FirebaseStorage {
    // FirebaseApp.configure()
    //Firebase storage
    
    //https://nonstop-d42.firebaseio.com/
    
    
    func readStorage() {
        //        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
        //            do {
        //                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        //                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        //                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
        //
        //                }
        //            } catch {
        //
        //            }
        //        }
        
        //let storage = Storage.storage()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let array = ref.child("Airports").child("LAX").child("Flight");
        print("Array", (/array));
        //        for object in array {
        //
        ////            let flight =
        //        }
        
        
        //        let userID = Auth.auth().currentUser?.uid
        //        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        //            // Get user value
        //            let value = snapshot.value as? NSDictionary
        //            let username = value?["username"] as? String ?? ""
        //            let user = User(username: username)
        //
        //            // ...
        //        }) { (error) in
        //            print(error.localizedDescription)
        //        }
    }
    
    //get Flight Time from flight Number
    func getFlightTime(flightNumber:String) -> String {
        let flightTime = ""
        return flightTime
    }
    
    
    
}


