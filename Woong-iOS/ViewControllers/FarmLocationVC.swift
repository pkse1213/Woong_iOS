//
//  FarmLocationVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 8..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit
import MapKit
class FarmLocationVC: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var registerationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerationButton.layer.masksToBounds = true
        registerationButton.layer.cornerRadius = 24/667 * self.view.frame.height
    }


}
