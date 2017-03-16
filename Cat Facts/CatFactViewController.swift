//
//  ViewController.swift
//  Cat Facts
//
//  Created by Hayden Goldman on 3/16/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData


class CatFactViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var factLabel: UILabel!
    var catFactText :String!
    var catImageUrl :String!
    var cats = [CatClass]()
    
    //Core Data Stuff
    var managedObjectContext :NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.getCatFact()
        self.getCatImage()
    }
    //Calls CatFact API
    func getCatFact() {

        let url = URL(string: "http://catfacts-api.appspot.com/api/facts")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            let catFacts = json["facts"] as! [String]
            let catFactInArray = catFacts[0]
            self.catFactText = catFactInArray
            DispatchQueue.main.async {
                self.factLabel.text = self.catFactText
            }
        }.resume()
    }
    
    //Calls CatImage API
    func getCatImage() {
        
        let url = URL(string: "http://random.cat/meow")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            let catImageUrl = json["file"] as! String
            self.catImageUrl = catImageUrl
            DispatchQueue.main.async {
                self.catImageView.kf.setImage(with: URL(string: self.catImageUrl))
            }
        }.resume()
    }
    
    //Fetches a new cat fact and image
    @IBAction func getFactButtonPressed(_ sender: Any) {
        self.getCatFact()
        self.getCatImage()
    }

    
    //Adds current cat fact into catFacts array
    @IBAction func saveFactButtonPressed(_ sender: Any){
        
        let cat = CatClass()
        cat.fact = self.catFactText
        cat.catImageUrl = self.catImageUrl
        self.cats.append(cat)
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ShowSavedFacts" {
            
            let savedFactsTVC = segue.destination as! SavedFactsTableViewController
            savedFactsTVC.cats = self.cats
            
        }
        
    }
    

}

