//
//  DetailViewController.swift
//  RideshareList
//
//  Created by Karl Becker on 1/12/19.
//  Copyright © 2019 KB Productions, LLC. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var getApp: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationDescriptionLabel: UILabel!
    
    @IBAction func getAppTapped(_ sender: Any) {
        if let detail = detailItem,
            let iosApp = detail.apps.first(where: {$0.platform == AppPlatform.ios}) {
            UIApplication.shared.open(iosApp.url, options: [:])
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.name
                self.navigationItem.title = detail.name
            }
            if let locationLabel = locationDescriptionLabel {
                locationLabel.text = detail.locationDescription
            }
            if let descriptionTextView = descriptionTextView {
                descriptionTextView.text = detail.description
            }
            if let map = map, let lat = detailItem?.locations[0].lat, let long = detailItem?.locations[0].long {
                map.centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                map.camera.altitude = 20000;
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let detail = detailItem {
            self.navigationItem.title = detail.name
        }
        super.viewWillAppear(animated)
    }

    var detailItem: RideshareService? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

