//
//  NewController.swift
//  ARetter
//
//  Created by Oshima Haruna on 2018/08/08.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import UIKit

class NewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet weak var textlabel: UILabel!
    var flag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textlabel.text = "マーカを登録しましょう"
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        textlabel.text = "メッセージを登録しましょう"
        dismiss(animated: true, completion: nil)
        
        if flag == 2{
            makeAlert1()
        }
    }
    
    @IBAction func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let picker = UIImagePickerController()
            
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
            
        }
        flag += 1
    }
    
    @IBAction func tappedTakePhoto(){
        useCamera()
        flag += 1
    }
    
    func makeAlert1(){
        print("alert")
        let alert: UIAlertController = UIAlertController(title: "確認", message: "これで登録しますか？", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "はい",
                style: .default,
                handler: { action in
                   self.makeAlert2()
            }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "いいえ",
                style: .default,
                handler: { action in
                    self.flag = 1
            }
            )
        )
        
        present(alert, animated:  true, completion: nil)
    }
    
    func makeAlert2(){
        print("alert")
        let alert: UIAlertController = UIAlertController(title: "登録完了", message: "Your regitation is completion!", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "戻る",
                style: .default,
                handler: { action in
                    self.navigationController?.popViewController(animated: true)
            }
            )
        )
        
        present(alert, animated:  true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
}
