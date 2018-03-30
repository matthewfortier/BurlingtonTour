//
//  PlaceViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/19/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PlaceViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //var delegate: ChildViewControllerDelegate?
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Body: UITextView!
    @IBOutlet weak var Map: MKMapView!
    
    var itemStore: ItemStore!
    var place: Place!
    
    // Set the favorite bar button icon and hook up the helper function
    func setFavoriteButton(filled: Bool) {
        var buttonIcon: UIImage!
        
        buttonIcon = filled ? UIImage(named: "fav-filled") : UIImage(named: "fav")
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.done, target: self, action: #selector(PlaceViewController.handleFavorite))
        
        rightBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // Switches the icon and adds or removes the favorite
    @objc func handleFavorite() {
        if itemStore.isFavorite(uuid: place.id) {
            itemStore.removeFavorite(uuid: place.id)
            setFavoriteButton(filled: false)
        } else {
            itemStore.addFavorite(uuid: place.id, type: "place")
            setFavoriteButton(filled: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the favorite button based on the current place
        setFavoriteButton(filled: itemStore.isFavorite(uuid: place.id))
        
        Image.image = UIImage(named: place.image)
        Body.text = place.body
        
        self.navigationItem.title = place.title
        
        // Create the map annotation with provided latitude and longitude
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(place.lat), longitude: CLLocationDegrees(place.lon))
        Map.addAnnotation(annotation)
        
        // Show the annotations
        Map.showAnnotations(Map.annotations, animated: true)
        // Do any additional setup after loading the view.
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors " + error.localizedDescription)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
