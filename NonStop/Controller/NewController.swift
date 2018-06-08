//
//  NewController.swift
//  NonStop
//
//  Copyright © 2018 Alexandra Klimenko. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class NewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate  {
   
    private let sharedModel = terminalModel.sharedInstance
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var scheduledDeparture: UILabel!
    
    @IBOutlet weak var gate: UILabel!
    @IBOutlet weak var terminal: UILabel!
    @IBOutlet weak var driveTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        map.showsScale = true
        map.showsPointsOfInterest = true
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            getDirections()
        }
        
        if (self.sharedModel.terminal != "") {
            self.terminal.text = self.sharedModel.terminal
        }
        
        if (self.sharedModel.gate != "") {
            self.gate.text = self.sharedModel.gate
        } else {
             self.gate.text = "N/A"
        }
        if (self.sharedModel.time != "") {
            self.scheduledDeparture.text = self.sharedModel.time
        }
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.swipeView.addGestureRecognizer(swipeUp)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "nonstopID3")
        
        self.present(newViewController, animated: true, completion: nil)
    }
   
    
    func getDirections() {
        let sourceCoordinates = self.manager.location?.coordinate
        var destCoordinates = CLLocationCoordinate2DMake(33.9416, -118.4085)
        
       
        switch (self.sharedModel.terminal) {
            case "2":
                destCoordinates = CLLocationCoordinate2DMake(33.945309, -118.403724)
            case "3":
                destCoordinates = CLLocationCoordinate2DMake(33.945193, -118.407165)
            case "4":
                destCoordinates = CLLocationCoordinate2DMake(33.942266, -118.406443)
            case "5":
                destCoordinates = CLLocationCoordinate2DMake(33.942559073, -118.404667619)
            case "6":
                destCoordinates = CLLocationCoordinate2DMake(33.942630, -118.402190)
            case "7":
                 destCoordinates = CLLocationCoordinate2DMake( 33.942559073, -118.404667619)
        default:
            break
        }
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            guard let response = response else {
                if error != nil {
                    print("SOMETHING WENT WRONG");
                }
                return
            }
            
            let route = response.routes[0];
            self.map.add(route.polyline, level: .aboveRoads)
            
           self.sharedModel.driveTime = route.expectedTravelTime
         
            self.driveTime.text = "\(Int(self.sharedModel.driveTime/60)) min"
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated:true)
        })
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)-> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay:overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
