//
//  DirectionsViewController.swift
//  MapTest
//
//  Created by Taras Kravchuk on 10/7/15.
//  Copyright © 2015 Taras Kravchuk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DirectionsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    var destination: MKMapItem?
    var desPlace: MKPlacemark!
    var annotation:MKAnnotation!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var locationManager: CLLocationManager?
    var endLocation: Location!
    var startLocation: Location!
    
    // Parking Location Coordinates
    let DoctorBuilding = CLLocationCoordinate2D(
        latitude: 47.648183,
        longitude: -117.413864
    )
    let ChildrenHospital = CLLocationCoordinate2D(
        latitude: 47.649214,
        longitude: -117.411316
    )
    let HeartInst = CLLocationCoordinate2D(
        latitude: 47.650346,
        longitude: -117.412597
    )
    let WomensHealth = CLLocationCoordinate2D(
        latitude: 47.648815,
        longitude: -117.415504
    )
    let ER = CLLocationCoordinate2D(
        latitude: 47.648252,
        longitude: -117.411494
    )
    
    
    
    //MARK - Outlets
    @IBOutlet var showRoute: MKMapView!
    @IBOutlet weak var DirectionsOutput: UITextView!
    
    //MARK - Funtions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = true //make top bar transluscent
        DirectionsOutput.editable = false
        DirectionsOutput.scrollEnabled = true
        self.DirectionsOutput.layer.borderWidth = 0.8
        self.DirectionsOutput.layer.borderColor = UIColor.init(red: 212/255, green: 212/255, blue: 212/255, alpha: 0.8).CGColor

        self.locationManager?.distanceFilter = kCLDistanceFilterNone
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        showRoute.showsUserLocation = true
        showRoute.mapType = .Standard
        showRoute.delegate = self
        viewCheck()

    }
    
    func setDestination(){
        switch endLocation.category{
            case "Heart Institute":
                desPlace = MKPlacemark(coordinate: HeartInst, addressDictionary: nil)
            case "Main Tower":
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
            case "Women's Health Center":
                desPlace = MKPlacemark(coordinate: WomensHealth, addressDictionary: nil)
            case "Doctors Building":
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
            case "Surgery Center":
                desPlace = MKPlacemark(coordinate: WomensHealth, addressDictionary: nil)
            case "Faith & Healing":
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
            case "Children's Hospital":
                desPlace = MKPlacemark(coordinate: ChildrenHospital, addressDictionary: nil)
            default:
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
        }
    }
    
    //Create the request for source and use destination to
    func getDirections(){
        let request = MKDirectionsRequest()
        setDestination()
        //let destination = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = MKMapItem(placemark: desPlace)

        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)

        directions.calculateDirectionsWithCompletionHandler{
            response, error in
            
            guard let response = response else {
                let alertTitle = "Error"
                let alertMessage = "Error getting directions"
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            self.showRoute(response)
        }
        
    }
    
    func showRoute(response: MKDirectionsResponse) {
        var i = 1
        for route in response.routes {
            
            showRoute.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
            
            for step in route.steps {
                DirectionsOutput.insertText("Step \(i) -- ")
                DirectionsOutput.insertText("In \(step.distance) Meters: \(step.instructions) \n")
                i++
                print(step.instructions)
            }
        }
        let userLocation = showRoute.userLocation.coordinate
        let region = MKCoordinateRegionMakeWithDistance(userLocation, 2000, 2000)
        
        showRoute.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay
        overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.blueColor()
            renderer.lineWidth = 5.0
            return renderer
    }
    

    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location " +
                "services is changed to: ", terminator: "")
            
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                print("Denied")
            case .NotDetermined:
                print("Not determined")
            case .Restricted:
                print("Restricted")
            default:
                print("Authorized")
                getDirections()
            }
            
    }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    /* Add the pin to the map and center the map around the pin */
    func viewCheck() {
        //super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                /* No */
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app")
            case .NotDetermined:
                /* We don't know yet, we have to ask */
                locationManager = CLLocationManager()
                if let manager = self.locationManager{
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                }
            case .Restricted:
                /* Restrictions have been applied, we have no access
                to location services */
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app")
            default:
                getDirections()
            }
            
            
        } else {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the
            user to enable the location services */
            print("Location services are not enabled")
        }
        
    }

    //MARK - Actions
    @IBAction func OpenAppleMaps(sender: AnyObject, forEvent event: UIEvent) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?saddr=\(showRoute.userLocation.coordinate.latitude),\(showRoute.userLocation.coordinate.longitude)&daddr=\(DoctorBuilding.latitude),\(DoctorBuilding.longitude)&dirflg=d")!)
    }

}

