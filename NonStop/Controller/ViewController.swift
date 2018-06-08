//
//  ViewController.swift
//  NonStop
//
//  Copyright © 2018 Alexandra Klimenko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    private let sharedModel = terminalModel.sharedInstance
    @IBOutlet weak var flight: UITextField!
    //Map
    @IBOutlet weak var map: MKMapView!
    let manager:CLLocationManager  = CLLocationManager()
    @IBOutlet weak var ButtonMap: UIButton!
    
    
    struct mystruct {
        var number = ""
        var terminal = ""
        var gate = ""
        var time = ""
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flight.delegate = self
        map.delegate = self
        map.showsScale = true
        map.showsPointsOfInterest = true
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
  
        if CLLocationManager.locationServicesEnabled() {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        //(33.943447, -118.409728) TBIT
        //create region or fence
        let terminal3Geofence:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(33.945193, -118.407165)
            , radius:10, identifier: "Terminal 3");
        manager.startMonitoring(for: terminal3Geofence)
        let terminal4Geofence:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(33.942266, -118.406443)
            , radius:10, identifier: "Terminal 4");
        manager.startMonitoring(for: terminal4Geofence)
        let terminal5Geofence:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake( 33.942559073, -118.404667619)
            , radius:10, identifier: "Terminal 5");
           manager.startMonitoring(for: terminal5Geofence)
        let terminal6Geofence:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(33.942630, -118.402190)
            , radius:10, identifier: "Terminal 6");
           manager.startMonitoring(for: terminal6Geofence)
        let terminal7Geofence:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake( 33.942559073, -118.404667619)
            , radius:10, identifier: "Terminal 7");
        manager.startMonitoring(for: terminal7Geofence)
    }
    
   
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        readStorage()
    }
    
    func readStorage() {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Airports/LAX/Flights");
        
        var times = [String]()
        var numbers = [String]()
        var terminals = [String]()
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            if (snapshot.childrenCount > 0) {
                for flights in snapshot.children.allObjects as! [DataSnapshot] {
                    guard  let flightObject = flights.value as? [String: AnyObject] else {
                        print("Error")
                        break
                    }
                    
                    let flightNumber = String(describing: flightObject["Flight Number"]!)
                    let flightTime = String(describing: flightObject["Flight Time"]!)
                    let terminal = String(describing: flightObject["Terminal"]!)
                    let gate = String(describing: flightObject["Gate"]!)
                    let airline = String(describing: flightObject["Airline"]!)
                    
                    guard let flightInput = self.flight.text else {
                        return
                    }
                    
                    if (flightInput == "\(flightNumber)") {
//                        print ("Flight Number: \(flightNumber)")
//                        print ("Flight Time: \(flightTime)")
//                        print ("Terminal: \(terminal)")
//                        print ("Gate: \(gate)")
                        self.sharedModel.gate = "\(gate)";
                        self.sharedModel.flightNumber = "\(flightNumber)";
                        self.sharedModel.terminal = "\(terminal)"
                        self.sharedModel.time = "\(flightTime)"
                        self.sharedModel.airline = "\(airline)"
                        self.timefunction(flightTime: "\(flightTime)")
                  
                        self.sharedModel.foo()
                        return
                    }
                    
                    times.append("\(flightTime)")
                    numbers.append("\(flightNumber)")
                    terminals.append("\(terminal)")
                }
            }
        })
    }
    
    func timefunction( flightTime: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Airports/LAX/Flights");
        var count = 0;
        var countAirline = 0
        ref.observe(DataEventType.value, with: {(snapshot) in
            if (snapshot.childrenCount > 0) {
        for flights in snapshot.children.allObjects as! [DataSnapshot] {
            guard  let flightObject = flights.value as? [String: AnyObject] else {
                print("Error")
                break
            }
            
            let terminal = String(describing: flightObject["Terminal"]!)
            let airline = String(describing: flightObject["Airline"]!)
            if (self.sharedModel.terminal.isEqual(terminal)) {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let time = String(describing: flightObject["Flight Time"]!)
                let date = formatter.date(from: time)!
                let MyDate = formatter.date(from: flightTime)!
                let t = date.timeIntervalSince(MyDate)
                if (abs(t) < 3600 ) {
                    count += 1
                    if (self.sharedModel.airline.isEqual(airline)) {
                        countAirline += 1
                    }
                }
                
            }
            //print(count)
            self.sharedModel.securityTime = count
            self.sharedModel.checkInTime = countAirline
            
                }
            
            }
            
        })
    }
   
    func locationManager(_ manager:CLLocationManager, didEnterRegion region:CLRegion ) {
        self.sharedModel.geofenceBool = true
        print(region.identifier)
    }
    
    func locationManager(_ manager:CLLocationManager, didExitRegion region:CLRegion ) {
        print("exit \(region.identifier)")
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)-> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay:overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        flight.resignFirstResponder()
        return (true)
    }
    
    func animate(block: @escaping () -> Void, with delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
            UIView.animate(withDuration: 0.25, animations: {
                block()
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

