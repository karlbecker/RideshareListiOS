//
//  OverviewViewController.swift
//  RideshareList
//
//  Created by Karl Becker on 1/12/19.
//  Copyright © 2019 KB Productions, LLC. All rights reserved.
//

import UIKit
import MapKit

var selectedService: RideshareService?;

extension OverviewViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to change the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! RideshareAnnotation
        selectedService = annotation.service
        self.performSegue(withIdentifier: "showService", sender: self)
    }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
//                 calloutAccessoryControlTapped control: UIControl) {
//        let location = view.annotation as! Artwork
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
//    }
}

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var detailViewController: DetailViewController? = nil
    var services = [RideshareService]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIBarButtonItem(barButtonSystemItem: .search, target: self, action: )
        //navigationItem.rightBarButtonItem = editButtonItem
        
        
        //navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let apiUrl = URL(string: "https://karlbecker.github.io/RidesharingData/api/v1/rideshare-services.json")!
        URLSession.shared.dataTask(with: apiUrl) { (data, response, error) -> Void in
            guard error == nil else {
                return
            }
            
            if let data = data {
                // Check if data was received successfully
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        let services = try decoder.decode([RideshareService].self, from: data)
                        
                        self.services.append(contentsOf: services)
                        
                        if let map = self.mapView {
                            map.addAnnotations(self.annotationsFrom(self.services))
                        }
                    }
                    catch {
                        print("Unexpected error: \(error)")
                    }
                }
            }
            }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: map annotations
    func annotationsFrom(_ services: [RideshareService]) -> [MKAnnotation] {
        let annotations: [MKAnnotation] = services.map { (service) -> MKAnnotation in
            return RideshareAnnotation(service: service)
        }
        return annotations
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showService" {
            if let service = selectedService {
                let controller = (segue.destination as! DetailViewController) //.topViewController //as! DetailViewController
                controller.detailItem = service
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

