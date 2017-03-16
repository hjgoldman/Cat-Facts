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

class SavedFactsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
        
    //core data stuff
    var managedObjectContext :NSManagedObjectContext!
    var fetchResultsController :NSFetchedResultsController<Cat>!
    var cat = Cat()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSFetchRequest<Cat>(entityName: "Cat")
        request.sortDescriptors = [NSSortDescriptor(key: "fact", ascending: true)]
        
        self.fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchResultsController.delegate = self
        try! self.fetchResultsController.performFetch()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = self.fetchResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatFactCell", for: indexPath)
        
        let cat = self.fetchResultsController.object(at: indexPath)
        cell.textLabel?.text = cat.fact
        cell.imageView?.kf.setImage(with: URL(string: cat.imageUrl!))
        
        return cell
    }
    
    //editing table
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == .insert {
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        } else if type == .delete {
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
    }

    //delete cell 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // delete the record
            
            let cat = self.fetchResultsController.object(at: indexPath)
            self.managedObjectContext.delete(cat)
            try! self.managedObjectContext.save()
        }
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CatDetail" {

            guard let indexPath: IndexPath = self.tableView.indexPathForSelectedRow else {
                fatalError("no selection made")
            }
            
            let catFact = self.fetchResultsController.object(at: indexPath)
            
            let catDetailVC = segue.destination as! CatDetailViewController
            catDetailVC.managedObjectContext = self.managedObjectContext
            
            catDetailVC.cat = catFact
            
        }
    }
    



}
