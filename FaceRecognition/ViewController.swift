//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Aubre Body on 4/7/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import CoreImage
class ViewController: UIViewController {

    let imageV = UIImageView()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageV)
        imageV.frame = view.frame
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.imageTapped(_:)))
        imageV.isUserInteractionEnabled = true
        imageV.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if imageV.image == nil {
            selectNewImage()
        }
    }
    
    // Remove red boxes from imageView
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        for subview in imageV.subviews {
            subview.removeFromSuperview()
        }
        
        selectNewImage()
    }
    
    func selectNewImage() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Detect and highlight any faces in selected image
    func Recognition() {
        
        guard let image = CIImage(image: imageV.image!) else { return }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        guard let faces = faceDetector?.features(in: image) else { return }
        
        // Convert the Core Image Coordinates to UIView Coordinates
        let imageSize = image.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -imageSize.height)
        
        for face in faces as! [CIFaceFeature] {
            
            print("Found bounds are \(face.bounds)")
            
            // Apply the transform to convert the coordinates
            var faceViewBounds = face.bounds.applying(transform)
            
            // Calculate the actual position and size of the rectangle in the image view
            let viewSize = imageV.bounds.size
            let scale = min(viewSize.width / imageSize.width,
                            viewSize.height / imageSize.height)
            let offsetX = (viewSize.width - imageSize.width * scale) / 2
            let offsetY = (viewSize.height - imageSize.height * scale) / 2
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            let faceBox = UIView(frame: faceViewBounds)
            
            
            faceBox.layer.borderWidth = 3
            faceBox.layer.borderColor = UIColor.lightGray.cgColor
            faceBox.backgroundColor = UIColor.clear
            
            imageV.addSubview(faceBox)
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        }
    }


}

