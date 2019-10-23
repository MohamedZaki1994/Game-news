//
//  FavoriteViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 7/4/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit
import CoreLocation

class FavoriteViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let favorite = try! Realm().objects(Favorite.self)
        print(favorite)

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let coordinatorRegion = MKCoordinateRegion(center: center, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(coordinatorRegion, animated: true)
            changeAnnotation(coordinate: location.coordinate)
        }
    }

    func changeAnnotation(coordinate: CLLocationCoordinate2D) {
        annotation.title = "you are here"
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let customAnnotationView = self.customAnnotationView(in: mapView, for: annotation)
        customAnnotationView.number = arc4random_uniform(10)
        return customAnnotationView
    }
    private func customAnnotationView(in mapView: MKMapView, for annotation: MKAnnotation) -> CustomAnnotationView {
        let identifier = "CustomAnnotationViewID"
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let customAnnotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            customAnnotationView.canShowCallout = true
            return customAnnotationView
        }
    }
}

class CustomAnnotationView: MKAnnotationView {
    private let annotationFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
    private let label: UILabel

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.label = UILabel(frame: annotationFrame.offsetBy(dx: 0, dy: -6))
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        self.label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.label.textColor = .white
        self.label.textAlignment = .center
        self.backgroundColor = .clear
        self.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }

    public var number: UInt32 = 0 {
        didSet {
            self.label.text = String(number)
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()
        UIColor.blue.set()
        context.fillPath()
    }
}
