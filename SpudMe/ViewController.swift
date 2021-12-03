//
//  ViewController.swift
//  SpudMe
//
//  Created by Joseph Knappenberger on 11/18/21.
//

import UIKit
import PhotosUI
import CropViewController

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func presentPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .automatic
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    @IBAction func openPicker(_ sender: UIButton) {
        presentPicker()
    }
    
   
    
}

extension ViewController: PHPickerViewControllerDelegate, CropViewControllerDelegate  {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            //Access your image
                            self.imageView.image = nil
                            self.imageView.image = image
                            let cropViewController = CropViewController(image: image)
                            cropViewController.delegate = self
                            self.present(cropViewController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
     
    }
   

    func cropViewController(_ cropViewController: CropViewController, didCropToImage imageNew : UIImage, withRect cropRect: CGRect, angle: Int) {
        updateImageViewWithImage(imageNew, fromCropViewController: cropViewController)
        
    }
    public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
            imageView.image = image
            //layoutImageView()
            
                self.imageView.isHidden = false
                cropViewController.dismiss(animated: true, completion: nil)
            
        }
}
