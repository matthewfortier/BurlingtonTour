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
    
    var body: String = ""
    var image: String = ""
    var navTitle: String = ""
    var lat: Float = 0.0
    var lon: Float = 0.0
    var fav: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        setFavoriteButton(filled: false)
    }
    
    func setFavoriteButton(filled: Bool) {
        var buttonIcon: UIImage!
        
        buttonIcon = filled ? UIImage(named: "fav-filled") : UIImage(named: "fav")
        
        let rightBarButton = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.done, target: self, action: #selector(PlaceViewController.addFavorite2))
        rightBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func addFavorite2() {
        if (fav){
            fav = false
            //sender.setTitle("Unfavorite", for: .normal)
            setFavoriteButton(filled: false)
        }
        else {
            fav = true
            //sender.setTitle("Favorite", for: .normal)
            setFavoriteButton(filled: true)
            
        }
    }

    
    @IBAction func addFavorite(_ sender: UIButton) {
        if (fav){
            fav = false
            sender.setTitle("Unfavorite", for: .normal)
        }
        else {
            fav = true
            sender.setTitle("Favorite", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Image.image = UIImage(named: image)
        Body.text = body
        
        self.navigationItem.title = navTitle
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        Map.addAnnotation(annotation)
        
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
