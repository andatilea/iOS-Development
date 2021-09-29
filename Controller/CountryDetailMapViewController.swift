//
//  CountryDetailMapViewController.swift
//  Pandemify
//
//  Created by Anda Tilea on 01.09.2021.
//

import UIKit
import MapKit

class CountryDetailMapViewController: UIViewController {
    var lat: Double?
    var long: Double?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMap()
    }
    func setupMap() {
        guard let latitude = lat, let longitude = long else {
            // the map will show the current location (Romania)
            self.alertMapNotAvailable()
            return
        }
        let locationCoordinate = CLLocationCoordinate2D.init(latitude: latitude,
                                                             longitude: longitude)
        mapView.setCenter(locationCoordinate, animated: true)
        let zoomRegion = MKCoordinateRegion.init(center: locationCoordinate,
                                                 latitudinalMeters: 600000,
                                                 longitudinalMeters: 600000)
        mapView.setRegion(zoomRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)
    }
    func alertMapNotAvailable() {
        // create the alert
        let alert = UIAlertController(title: "Visualization on map not available",
                                      message: "No location available",
                                      preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
