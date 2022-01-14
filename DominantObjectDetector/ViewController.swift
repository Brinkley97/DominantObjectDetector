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
//        TODO :
//            use a UIKit UIImagePickerController object to allow users to select a photo from the phone library
        let choose = UIImagePickerController()
        
//        can add 1 & 2 above on line w/ class ViewController or as an extension (below) bc of self:
//          1. UIImagePickerControllerDelegate
//          2. UINavigationControllerDelegate
        choose.delegate = self
        
//        sourceType : type of picker interface to be displayed by the controller
//        .photoLibrary will soon be deprecated so use PHPicker
        choose.sourceType = .photoLibrary
//        choose.sourceType = PHPicker
        present(choose, animated: true)
    }

//       TODO :
//          check 1) device has camera, 2) user grant app access to camera
//          if both pass, then create a UIKit UIImagePickerController object - allows user to take a picture
    @IBAction func onSelectImageFromCamera(_ sender: Any) {

//        cam available?
        guard UIImagePickerController.isSourceTypeAvailable(.camera)
        
//        no, cannot access cam
        else {
            let alertController = UIAlertController(title: "Error", message: "Could not access the camera.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
//        yes, can access cam
        let choose = UIImagePickerController()
        choose.delegate = self
        choose.sourceType = .camera
        present(choose, animated: true)
        
    }
    
//    method
    func detectDominantObject(in image: UIImage) {
//        to do : code to perform object detec w/ Core ML
        <#function body#>
    }
}

//    TODO :
//      Implement the UIImagePickerControllerDelegate method along w/ the func imagePickerController in a class extension
extension ViewController: UIImagePickerControllerDelegate,
                          UINavigationControllerDelegate {

//    tells delegate : user has picked a still image/ video
    func imagePickerController(_ choose: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        choose.dismiss(animated: true)
        
//        .InfoKey : get info on media selected by the user
        let img = info[UIImagePickerController.InfoKey.originalImage]
        
//        as! : "!" [indicates that the conversion may fail]
//          [see more](https://developer.apple.com/swift/blog/?id=23)
                  as! UIImage
        
//      display picture selected/taken by user in imageView (created above) object of user interface
        imageView.image = img
        
//        method to perform object detection
        detectDominantObject(in: img)
        
        
    }
}
