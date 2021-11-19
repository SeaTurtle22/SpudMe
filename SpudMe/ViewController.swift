//
//  ViewController.swift
//  SpudMe
//
//  Created by Joseph Knappenberger on 11/18/21.
//

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController,PHPickerViewControllerDelegate{
    @IBOutlet var frame: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hi Cedar!
    }
    @IBAction func chosephoto(_ sender: Any) {
    var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration:config)
        vc.delegate = self
    present(vc, animated: true)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) {reading, error in
                guard let image = reading as? UIImage, error == nil else{
                    return
                }
            }
        }
    }
    



}

