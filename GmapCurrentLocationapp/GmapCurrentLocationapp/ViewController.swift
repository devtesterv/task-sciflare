//
//  ViewController.swift
//  GmapCurrentLocationapp
//
//  Created by CV on 6/8/23.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import Contacts


class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var llLocationLabel:UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
    }
    func getCurrentLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //        print("locationslocationslocationslocations",locations)
        //           print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        llLocationLabel.text = "latitude = \(locValue.latitude), longitude = \(locValue.longitude)"
        let position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.placemark { [self] placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
//            print(placemark.postalAddressFormatted ?? "")
//            print(placemark.streetName ?? "")
//            print(placemark.streetNumber ?? "")
//            print(placemark.city ?? "")
//            print(placemark.country ?? "")
//            print(placemark.name ?? "")
//            print(placemark.state ?? "")
//            print(placemark.zipCode ?? "")
            lblLocation.text = "\(placemark.streetName ?? "StreetName Nil") \(placemark.streetNumber ?? "StreetNumber Nil" ) \(placemark.postalAddressFormatted ?? "Address Nil") "
        }
        
    }
    
    
    
}


extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}
extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
