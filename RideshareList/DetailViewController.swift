//
//  DetailViewController.swift
//  RideshareList
//
//  Created by Karl Becker on 1/12/19.
//  Copyright © 2019 KB Productions, LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: RideshareService? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

