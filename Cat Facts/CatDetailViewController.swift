//
//  CatDetailViewController.swift
//  Cat Facts
//
//  Created by Hayden Goldman on 3/16/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class CatDetailViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catFactLabel: UILabel!
    
    var cat = CatClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.catFactLabel.text = self.cat.fact
        self.catImageView.kf.setImage(with: URL(string: self.cat.catImageUrl))
        
    }
    



}
