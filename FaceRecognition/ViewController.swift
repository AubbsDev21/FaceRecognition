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

    let imageV: UIImageView = {
        let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        let tapview = UITapGestureRecognizer(target: self, action: #selector(SelcethandleView(sender:)))
        view.addGestureRecognizer(tapview)
        return view
    }()
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageV)
        setup()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        if imageV.image == nil {
            selectImage()
        }
    }
    
    func Recognition() {
        guard let image = CIImage(image: imageV.image!) else { return }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDecteor = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        guard let faces = faceDecteor?.features(in: image) else { return }
        
        //convert the core Image Coordinates to UIView Coordinate
        let imageSize = image.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -imageSize.height)
        
        for face in faces as! [CIFaceFeature] {
            
            print("Found bounds are \(face.bounds)")
            
            //apply the transform to convert the coordinates
            var faceVeiwBounds = face.bounds.applying(transform)
            
            //calculate the actual postion and size of the rectangle in the image veiw
            let veiwSize = imageV.bounds.size
            let scale = min(veiwSize.width / imageSize.width, veiwSize.height / imageSize.height)
            
            let offsetX = (veiwSize.width - imageSize.width * scale)
            let offsetY = (veiwSize.height -  imageSize.height * scale)
            
            faceVeiwBounds = faceVeiwBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceVeiwBounds.origin.x += offsetX
            faceVeiwBounds.origin.y += offsetY
            
            let faceBox = UIView(frame: faceVeiwBounds)
            
            faceBox.layer.borderWidth = 3
            faceBox.layer.borderColor = UIColor.darkGray.cgColor
            faceBox.backgroundColor = UIColor.clear
        }
        
    }

    func setup() {
        imageV.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageV.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    
    }
}

