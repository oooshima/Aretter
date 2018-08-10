//
//  NewController.swift
//  ARetter
//
//  Created by Oshima Haruna on 2018/08/08.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos
import AVFoundation

class NewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var markerImageView: UIImageView!
    @IBOutlet var messageImageView: UIImageView!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var debugTextlabel: UILabel!
    
    var flag = 0
    
    var videoURL: URL?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textlabel.text = "マーカを登録しましょう"
       
        
        // タイマーを作る
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewController.onUpdate(timer:)), userInfo: nil, repeats: true)
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
    
    func useVideoCamera() {
        // カメラが利用できる端末かどうか確認
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let ipc: UIImagePickerController = UIImagePickerController()
            ipc.delegate = self
            ipc.sourceType = UIImagePickerControllerSourceType.camera
            ipc.mediaTypes = [kUTTypeMovie] as [String] // ここで動画を指定する。
            ipc.allowsEditing = false
            ipc.showsCameraControls = true
            self.present(ipc, animated: true, completion: nil)
        } else {
            print("この端末ではカメラを利用できません")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //画像撮って戻ってきたとき
        if ((info[UIImagePickerControllerEditedImage] as? UIImage) != nil){
            flag += 1
          
                markerImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
                textlabel.text = "メッセージを登録しましょう"
          
        }
        
    //ビデオ撮って戻ってきたとき
        if (info[UIImagePickerControllerMediaURL] as? NSURL) != nil {
            flag += 1
            
            videoURL = info[UIImagePickerControllerMediaURL] as? URL
            messageImageView.image = previewImageFromVideo(videoURL!)!
            
        }
            dismiss(animated: true, completion: nil)
        
            if flag == 2{
            makeAlert1()
            }
        }
    
    
    func previewImageFromVideo(_ url:URL) -> UIImage? {
        print("動画からサムネイルを生成する")
        let asset = AVAsset(url:url)
        let imageGenerator = AVAssetImageGenerator(asset:asset)
        imageGenerator.appliesPreferredTrackTransform = true
        imageGenerator.maximumSize = self.view.frame.size
        var time = asset.duration
        time.value = min(30,32)
    
        let step:Float64 = 0.0//ここの数字をいじると、切り出す秒数がかわるよ！
        let midpoint = CMTimeMakeWithSeconds(step, 30);
        do {
            let imageRef = try imageGenerator.copyCGImage(at: midpoint, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            return nil
        }
    }
    
    
    
    @IBAction func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let picker = UIImagePickerController()
            
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            if flag == 0{
                //画像だけ
                picker.mediaTypes = ["public.image"]
            }
            if flag == 1{
                //動画だけ
                picker.mediaTypes = ["public.movie"]
            }
            
            present(picker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func tappedTakePhoto(){
        if flag == 0{
            useCamera()
        }
        if flag == 1{
            useVideoCamera()
        }
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
                   self.flag = 3
            }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "いいえ",
                style: .default,
                handler: { action in
                    self.flag = 1
                    self.messageImageView.image = nil
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
    
    
    
    
    // TimerのtimeIntervalで指定された秒数毎に呼び出されるメソッド
    @objc func onUpdate(timer : Timer){
        
    debugTextlabel.text = String(flag)
        
    }
    
    
    
    
    
    
}
