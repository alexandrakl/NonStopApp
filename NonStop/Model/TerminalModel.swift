//
//  TerminalModel.swift
//  NonStop
//
//  Copyright © 2018 Alexandra Klimenko. All rights reserved.
//

import Foundation
import SwiftyJSON

final class terminalModel {
    static let sharedInstance = terminalModel()
    private init() {}
    
    var flightNumber = ""
    var terminal = ""
    var gate = ""
    var time = ""
    var securityTime = 0
    var driveTime = 0.0
    var airline = ""
    var checkInTime = 0
    
    var geofenceBool = false
    
    public var foods = [FoodShop]()
    
    //create an array of tuples to store the coordinates of each terminal
    //each index in array is the number of terminal
    //with one exception the Tom Bradley International Airport which has 2: stored at 0 index & 9 index
    typealias coordinate = (latitude: Double, longitude: Double)
    
    let terminalCoordinatesArray: [coordinate] = [
        (33.944740651, -118.410685443),     //      TBIT: (33.944740651, -118.410685443)   (33.940904496, -118.410127543)
        (33.947023407, -118.401250024),     //      Terminal 1: (33.947023407, -118.401250024)
        (33.94695311, -118.40439211),       //      Terminal 2: (33.946953, -118.404392)
        (33.941116557, -118.406807370),     //      Terminal 4: (33.941116557, -118.406807370)
        (33.941286489, -118.404436298),     //      Terminal 5: (33.941286489, -118.404436298)
        (33.941472485, -118.402062733),     //      Terminal 6: (33.941472485, -118.402062733)
        (33.941686472, -118.399638016),     //      Terminal 7: (33.941686472, -118.399638016)
        (33.942032628, -118.397390325),     //      Terminal 8: (33.942032628, -118.397390325)
        (33.940904496, -118.410127543)      //      TBIT: (33.944740651, -118.410685443)   (33.940904496, -118.410127543)
    ]

    func foo(){
        
    if terminal != "" {
        foods.removeAll()
        var terminalCoordinate = "&latitude=33.944740651&longitude=-118.410685443"
        if terminal == "TBIT" {
         terminalCoordinate = "&latitude=\(terminalCoordinatesArray[1].latitude)&longitude=\(terminalCoordinatesArray[1].longitude)"
        } else {
            terminalCoordinate = "&latitude=\(terminalCoordinatesArray[Int(terminal)!-1].latitude)&longitude=\(terminalCoordinatesArray[Int(terminal)!-1].longitude)"
        }

        var stringURL = "https://api.yelp.com/v3/businesses/search?term=food&radius=90";
        stringURL += terminalCoordinate
        guard let url = URL(string: stringURL) else {
            print ("ERROR:" )
            return
        }
        
        let urlRequest =  URLRequest(url: url)
//      print (urlRequest)
        let key = "gwbBR5UUAVBphCLXADXZqtux4yqOwyfbZG-T3bylhgbzDK1uH94NcCBPPonZCLoM1Q2pxUyL3-58WfzFLxSw5gPz3hk2kM8uPiIp9ZKYBwc8PtZqPDXlfTFlaOvbWnYx"
    
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String = "Bearer \(key)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue]
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            let json = try! JSON(data: data!)
            //print(json["businesses"])
            // var count = 0
            if let count = Int("\(json["total"])"){
                //print ("Count \(count)")
                for index in 1...count {
                    if let name = json["businesses"][index-1]["name"].string {
                         print ("\(name)")
                        if let rating = json["businesses"][index-1]["rating"].int {
                            // print ("\(rating)")
                            if let price = json["businesses"][index-1]["price"].string {
                                // print ("\(price)")
                                if let imageUrl = json["businesses"][index-1]["image_url"].string {
                                    //print ("\(imageUrl)")
                                    if let latitude = json["businesses"][index-1]["coordinates"]["latitude"].double {
                                        //print ("\(latitude)")
                                        if let longitude = json["businesses"][index-1]["coordinates"]["longitude"].double {
                                            //print ("\(longitude)")
                                            if let s = FoodShop(name: "\(name)", rating: rating, price: price, imageUrl: imageUrl, longitude: longitude, latitude: latitude) {
                                                self.foods.append(s)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
        task.resume()
        }
    }
}




