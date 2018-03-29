//
//  TourViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/22/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit
import AVKit

class TourViewController: AVPlayerViewController {
    var itemStore: ItemStore!
    var tour: Tour!
    
    func setFavoriteButton(filled: Bool) {
        var buttonIcon: UIImage!
        
        buttonIcon = filled ? UIImage(named: "fav-filled") : UIImage(named: "fav")
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.done, target: self, action: #selector(TourViewController.handleFavorite))
        
        rightBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func handleFavorite() {
        if itemStore.isFavorite(uuid: tour.id) {
            itemStore.removeFavorite(uuid: tour.id)
            setFavoriteButton(filled: false)
        } else {
            itemStore.addFavorite(uuid: tour.id, type: "tour")
            setFavoriteButton(filled: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFavoriteButton(filled: itemStore.isFavorite(uuid: tour.id))
        
        self.navigationItem.title = tour.title
        
        guard let path = Bundle.main.path(forAuxiliaryExecutable: tour.file) else {
            debugPrint("video.m4v not found")
            return
        }
        self.player = AVPlayer(url: URL(fileURLWithPath: path))
        self.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
