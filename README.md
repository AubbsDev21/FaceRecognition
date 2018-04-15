FaceRecognition
================
A Face recognition Demo that uses apples coreimage

## Demo
* Single face

![facerecdemo](https://user-images.githubusercontent.com/16025198/38771772-0fc2448c-3ff7-11e8-91a9-c83df6dae985.gif)

* Multiple face 

![facerec2demo](https://user-images.githubusercontent.com/16025198/38771774-142a4632-3ff7-11e8-92e5-6f81a35ca585.gif)

## Example Code 
Detecting a face or multiple faces 
```bash
 let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        guard let faces = faceDetector?.features(in: image) else { return }
        
        // Convert the Core Image Coordinates to UIView Coordinates
        let imageSize = image.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -imageSize.height)
```
This takes the ponits around the face in a loop and creates a box around it.
bash```
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
````
