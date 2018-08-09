//
//  ScanController.swift
//  ARetter
//
//  Created by Oshima Haruna on 2018/08/08.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import UIKit

class ScanController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        useCamera()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func useCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let picker = UIImagePickerController()
            
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }else{
            print("error")
        }
    }

}
