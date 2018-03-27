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
    
    var tourTitle: String!
    var file: String!
    
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
//        if (fav){
//            fav = false
//            //sender.setTitle("Unfavorite", for: .normal)
//            setFavoriteButton(filled: false)
//        }
//        else {
//            fav = true
//            //sender.setTitle("Favorite", for: .normal)
//            setFavoriteButton(filled: true)
//            
//        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = tourTitle
        
        guard let path = Bundle.main.path(forAuxiliaryExecutable: file) else {
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
