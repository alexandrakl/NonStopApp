//
//  FoodTable.swift
//  NonStop
//
//  Copyright © 2018 Alexandra Klimenko. All rights reserved.
//

import Foundation
import UIKit

struct Shop {
    var name = "";
    var rating = 0;
    var longitude = 0.0;
    var latitude = 0.0;
}

class FoodTable: UITableViewController {
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var model = terminalModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.target = self
        backButton.action = #selector(FoodTable.back(sender:))
        backButton.style = UIBarButtonItemStyle.plain
    }
    
    @objc func back(sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "nonstopID3")
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodcell", for: indexPath) as? FoodTableCell  else {
            fatalError("The dequeued cell is not an instance of FoodTableCell.")
        }
        let shop = model.foods[indexPath.row]
        cell.nameLabel.text = shop.name
        cell.photoImageView.image = shop.photo
        cell.rating.rating = shop.rating
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.foods.count
    }
}
