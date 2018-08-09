//
//  ScanController.swift
//  ARetter
//
//  Created by Oshima Haruna on 2018/08/08.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import UIKit
import KudanAR
import Realm
import RealmSwift
class ScanController: ARCameraViewController{
    let samples:[Dictionary<String, String>] = [["id":"1","marker":"sample2.jpeg","movie":"sample.MP4"],
                                                ["id" :"2","marker" :"marino_icon2.png", "movie":"sample.MOV"]]
    private let imageName = "trackerImage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func setupContent() {
        setupTracker()
        setupVideo()
    }
    
    private func setupTracker() {
        let tracker = ARImageTrackerManager.getInstance()
        tracker?.initialise()
        
        //        tracker?.setMaximumSimultaneousTracking(5)
        
//        for test in samples{
//            print(test)
//            let marker = test["marker"]!
//            let movie = test["movie"]!
//            print(marker)
//            print(movie)
//
//        }
        
        let realm = try! Realm()
        let aretters = realm.objects(ARetter.self)
        for aretter in aretters {
            let url = URL(string: aretter.image)
            let data = try? Data(contentsOf: url!)
            let imageTrackable = ARImageTrackable(image: UIImage(data: data!),name: aretter.id)
            tracker?.addTrackable(imageTrackable)
        }
    }
    
    
    private func setupVideo() {
        //        print("マーカーを認識した")

        
//        for test in samples{
//            print(test)
//            let tracker = ARImageTrackerManager.getInstance()
//            if let imageTrackable = tracker?.findTrackable(byName: test["marker"]){
//                let videoNode = ARVideoNode(bundledFile: test["movie"])
//
//                imageTrackable.world.addChild(videoNode)
//
//                let scaleFactor = Float(imageTrackable.height) / Float((videoNode?.videoTexture.height)!)
//                videoNode?.scale(byUniform: scaleFactor)
//                videoNode?.play()
//
//                // 動画をフェードインさせる（時間）
//                videoNode?.videoTextureMaterial.fadeInTime = 1
//                // リセットのしきい値
//                videoNode?.videoTexture.resetThreshold = 2
//
//                // 動画をタップしたアクション
//                videoNode?.addTouchTarget(self, withAction: #selector(videoWasTouched))
//            }
//            else{
//                fatalError("Could not find imageTrackable")
//            }
//        }
        
        let realm = try! Realm()
        let aretters = realm.objects(ARetter.self)
        for aretter in aretters {
            
            let tracker = ARImageTrackerManager.getInstance()
            if let imageTrackable = tracker?.findTrackable(byName: aretter.id){
                let videoNode = ARVideoNode(bundledFile: aretter.message)
                
                imageTrackable.world.addChild(videoNode)
                
                let scaleFactor = Float(imageTrackable.height) / Float((videoNode?.videoTexture.height)!)
                videoNode?.scale(byUniform: scaleFactor)
                videoNode?.play()
                
                // 動画をフェードインさせる（時間）
                videoNode?.videoTextureMaterial.fadeInTime = 1
                // リセットのしきい値
                videoNode?.videoTexture.resetThreshold = 2
                
                // 動画をタップしたアクション
                videoNode?.addTouchTarget(self, withAction: #selector(videoWasTouched))
            }
            else{
                fatalError("Could not find imageTrackable")
            }

        }
    }
    
    @objc func videoWasTouched(videoNode: ARVideoNode) {
        // 最初から再生させる
        videoNode.reset()
        videoNode.play()
    }
}
