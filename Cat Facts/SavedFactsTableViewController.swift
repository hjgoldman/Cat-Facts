//
//  SavedFactsTableViewController.swift
//  Cat Facts
//
//  Created by Hayden Goldman on 3/16/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class SavedFactsTableViewController: UITableViewController {
    
    var cats = [CatClass]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cats.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatFactCell", for: indexPath)

        let cat = self.cats[indexPath.row]
        
        cell.textLabel?.text = cat.fact
        
        cell.imageView?.kf.setImage(with: URL(string: cat.catImageUrl)!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CatDetail" {
            
            guard let indexPath: IndexPath = self.tableView.indexPathForSelectedRow else {
                fatalError("no selection made")
            }

            let cat = self.cats[indexPath.row]
            
            let catDetailVC = segue.destination as! CatDetailViewController
            
            catDetailVC.cat = cat
            
            
        }
    }
    



}
