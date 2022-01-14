//
//  ViewController.swift
//  DominantObjectDetector
//
//  Created by Detravious J. Brinkley on 1/13/22.
//

import UIKit

class ViewController: UIViewController {
    
//    outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSelectImageFromPhotoLibrary(_ sender: Any) {
    }

    @IBAction func onSelectImageFromCamera(_ sender: Any) {
    }
}

