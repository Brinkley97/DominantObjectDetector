//
//  ViewController.swift
//  DominantObjectDetector
//
//  Created by Detravious J. Brinkley on 1/13/22.
//

import UIKit
import CoreML

// use to perform object detec w/ a custom Core ML mode
import Vision

class ViewController: UIViewController {
    
//    outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    
// TODO :
//    use Vision framework
//    encapsulate request into a VNCoreMLRequest object
//    use VNImageRequestHandler object to execute request
    
//    lazy var : execute only when accessing the classificationRequest var from code & ! when class is loaded
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let get_model = try VNCoreMLModel(for: Resnet50().model)
            
//            completionHandler calls the processResults method/func below
            let get_request = VNCoreMLRequest(model: get_model,
                    completionHandler: { [weak self] request, error in
                        self?.processResults(for: request, error: error)
            })
            
//            imageCropAndScaleOption : property used by Vision. how to scale img to required by model; 3 types, use type that matches model
//            centerCrop : resizes proportionally until dims of img = dims of model, crops into square by using center portion
            get_request.imageCropAndScaleOption = .centerCrop
            return get_request
        } catch {
            fatalError("Failed to load Core ML model")
        }
    }()
    
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
    
//    TODO :
//        Create & execute VNCoreMLRequest when user selects img
//    method
    func detectDominantObject(in img: UIImage) {
//        to do : code to perform object detec w/ Core ML
        resultLabel.text = "Processing..."
        percentLabel.text = "Processing..."
        
//        CIImage : a rep of an img to be processed or produced by Core Img filters so
//          converts UIImage inst --> CIImage inst
        guard let ciImage = CIImage(image: img),
            
            let orientation = CGImagePropertyOrientation(rawValue: UInt32(img.imageOrientation.rawValue))
            
            else {
                print("Unable to creat CIImage instance")
                resultLabel.text = "Failed."
                return
            }
//        creates a VNImageRequestHandler obj w/ CIImage inst which can run VNCoreMLRequest - performed by calling perfom on handler obj
//        VNImageRequestHandler & VNCoreMLRequest here to ! block app user-interface while running Core ML
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
            
        }
    }
    
//    TODO :
//      Accept two params : 1) VNRequest instance & 2) error object (optional)
//      Create VNCoreMLRequest & process results of the img classification
    func processResults(for get_request: VNRequest, error: Error?) {
//        DQ : an object that manages excution of tasks on app's thread (main or background)
//        async : schedules asynchronously [adj doesn't happen at the same time] for executution
        DispatchQueue.main.async {
//            get_results : returned as an arr of VNClassification Observation objects
            guard let get_results = get_request.results
            
//            cannot classify img due to error
            else {
                print("Unable to classify image.\n\(error!.localizedDescription)")
                self.resultLabel.text = "Unable to classify image."
                return
            }
            
//            VNClassification Observation : each object has two member vars : 1) identifier (class of detec obj) & 2) confidence (pr() of that class)
            let classifications = get_results as! [VNClassificationObservation]
            
//            cannot recognize img
            if classifications.isEmpty {
                self.resultLabel.text = "Did not recognize anything."
            }
//            can reconize img so state the class img belongs to & how confident model is in recongizing the img
            else {
//                results are sorted in descending order of pr()
//                get first item w/ [0] - most probable
                let id = classifications[0].identifier
                let con = classifications[0].confidence * 100
                
                self.resultLabel.text = id
                self.percentLabel.text = con.description
                
            }
        }
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
