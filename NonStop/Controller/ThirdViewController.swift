//
//  ThirdViewController.swift
//  NonStop
//
//  Copyright © 2018 Alexandra Klimenko. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var one: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var three: UIView!
    @IBOutlet weak var swipeView: UIView!
    
    @IBOutlet weak var driveTime: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    @IBOutlet weak var securityTime: UILabel!
    @IBOutlet weak var overallTime: UILabel!
    
    private let sharedModel = terminalModel.sharedInstance
    
    
    override func viewDidLoad() {
             // Do any additional setup after loading the view.
        super.viewDidLoad()
        one.layer.cornerRadius = 7
        two.layer.cornerRadius = 7
        three.layer.cornerRadius = 7
        progressBar.layer.cornerRadius = 7
        swipeView.layer.cornerRadius = 7
        
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 5)
     
        let timeToDrivetoLAX = Int(sharedModel.driveTime/60)
        driveTime.text = "\(timeToDrivetoLAX) min"
        securityTime.text = "\(self.sharedModel.securityTime+5) min"
        checkInTime.text = "\(self.sharedModel.checkInTime*2) min"
        print("PRINTING TIMES AND THEIR SUM:\(timeToDrivetoLAX) + \(Int(self.sharedModel.securityTime)) + 20 \(timeToDrivetoLAX + Int(self.sharedModel.securityTime) + 20)" )
        let timeTotal = timeToDrivetoLAX + Int(self.sharedModel.securityTime*2) + Int(self.sharedModel.checkInTime) + 20
        let timeHour = Int(timeTotal/60)
        let timeMin = Int(timeTotal%60)
        overallTime.text = "Overall Time \(timeHour)h \(timeMin)min"

        let swipeUp = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.swipeView.addGestureRecognizer(swipeUp)
        
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(self.sharedModel.geofenceBool == true) {
          one.backgroundColor = UIColor.gray
            progressBar.progress = 0.25
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let newViewController = storyBoard.instantiateViewController(withIdentifier: "nonstopID4")
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "nonstopID5")
        self.present(newViewController, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
