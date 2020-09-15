//
//  KLLiveController.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/28.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
import AVFoundation

class KLLiveController: UIViewController {
    
    lazy var rBeginBtn: UIButton = {
        
        let btn = UIButton(type:UIButton.ButtonType.custom)
        
        btn.setTitle("开始采集", for: .normal)
        btn.backgroundColor = UIColor.randomColor()
        
        btn.reactive.controlEvents(.touchUpInside).observeValues {[weak self] (btn) in
            print("开始采集")
            
            self?.startCApture()
            
        }
        
        
        return btn
    }()
    
    lazy var rStopBtn: UIButton = {
        
        let btn = UIButton(type:UIButton.ButtonType.custom)
        btn.backgroundColor = UIColor.randomColor()
        
        btn.setTitle("停止采集", for: .normal)
        
        btn.reactive.controlEvents(.touchUpInside).observeValues {[weak self] (btn) in
            
            print("停止采集")
            
            self?.stopCapture()
            
            
        }
        
        
        return btn
    }()
    
    lazy var rSwitchBtn: UIButton = {
        
        let btn = UIButton(type:UIButton.ButtonType.custom)
        btn.backgroundColor = UIColor.randomColor()
        
        btn.setTitle("切换摄像头", for: .normal)
        
        btn.reactive.controlEvents(.touchUpInside).observeValues {[weak self] (btn) in
            print("切换")
            
            self?.switchScreen()
        }
        
        //
        
        return btn
    }()
    
    lazy var rSession : AVCaptureSession = AVCaptureSession()
    
    lazy var rPreViewLayer : AVCaptureVideoPreviewLayer =  AVCaptureVideoPreviewLayer(session: self.rSession)
    
    var rVideoOutput : AVCaptureVideoDataOutput?
    
    var rVideoInput : AVCaptureDeviceInput?
    
    lazy var rMoveFileOut : AVCaptureMovieFileOutput = AVCaptureMovieFileOutput()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "直播"
        
        setupUI()
        
    }
    
    
}


extension KLLiveController {
    
    func setupUI ()  {
        
        
        
        view.addSubview(rBeginBtn)
        view.addSubview(rStopBtn)
        
        view.addSubview(rSwitchBtn)
        
        
        rBeginBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 120, height: 60))
            make.centerX.equalToSuperview()
        }
        
        rStopBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(250)
            make.size.equalTo(CGSize(width: 120, height: 60))
            make.centerX.equalToSuperview()
        }
        
        rSwitchBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(350)
            make.size.equalTo(CGSize(width: 120, height: 60))
            make.centerX.equalToSuperview()
        }
    }
    
    func startCApture()  {
        
        //开始采集
        setupVideo()
        setupAudio()
        
        //添加写入文件
        let movefile = AVCaptureMovieFileOutput()
        rSession.addOutput(movefile)
        rMoveFileOut = movefile
        
        
        //设置写入的稳定性
        let connection = movefile.connection(with: .video)
        connection?.preferredVideoStabilizationMode = .auto
        
        //给用户一个预览图层
        rPreViewLayer.frame = view.bounds
        view.layer.insertSublayer(rPreViewLayer, at: 0)
        
        //开始采集
        rSession.startRunning()
        
        //将采集的画面写入到文件
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abc.mp4"
        let url = URL(fileURLWithPath: path)
        
        movefile.startRecording(to: url, recordingDelegate: self)
        
    }
    
    
    func stopCapture ()  {
        
        rSession.stopRunning()
        rPreViewLayer.removeFromSuperlayer()
        rMoveFileOut.stopRecording()
        
        
    }
    
    
    func switchScreen()  {
        
        //获取当前摄像头
        guard var position = rVideoInput?.device.position else { return }
        //修改方向
        position =  position == .front ? .back : .front
        
        
        //根据当前摄像头创建新的device
        let devices = AVCaptureDevice.devices(for: .video)
        
        guard let dev  = devices.filter({$0.position == position}).first else { return }
        
        //        根据新的device创建Input
        
        guard let videoInput =  try? AVCaptureDeviceInput(device: dev) else { return  }
        
        
        //在session中切换Input
        
        rSession.beginConfiguration()
        rSession.removeInput(rVideoInput!)
        
        rSession.addInput(videoInput)
        
        rSession.commitConfiguration()
        
        rVideoInput = videoInput
        
        
    }
}



extension KLLiveController  {
    
    
    //设置视频输入/输出
    func setupVideo () {
        //获取摄像头设备
        
        guard let devices = AVCaptureDevice.devices(for: .video) as? [AVCaptureDevice] else {
            print("摄像头不可用")
            return
        }
        
        //        let dev = devices.filter { (devic) -> Bool in
        //            return devic.position == .front
        //        }.first
        
        guard let dev = devices.filter({$0.position == .front}).first else { return  }
        
        
        //设置input到会话
        guard let videoInput = try? AVCaptureDeviceInput(device: dev) else { return  }
        
        rVideoInput = videoInput
        rSession.addInput(videoInput)
        
        //设置输出
        let videoOutput = AVCaptureVideoDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        rSession.addOutput(videoOutput)
        
        //获取video的output
        rVideoOutput = videoOutput
        
    }
    
    //设置音频输入/输出
    func  setupAudio ()  {
        
        
        //音频设备
        guard let deviece = AVCaptureDevice.default(for: .audio) else { return   }
        
        guard let audioInput = try? AVCaptureDeviceInput(device: deviece) else { return }
        //将输入添加进会话
        rSession.addInput(audioInput)
        
        //设置音频输出
        let audioOutPut = AVCaptureAudioDataOutput()
        audioOutPut.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        
        rSession.addOutput(audioOutPut)
        
        
        
    }
}
//MARK:- 视频采集/音频采集
extension KLLiveController : AVCaptureVideoDataOutputSampleBufferDelegate ,AVCaptureAudioDataOutputSampleBufferDelegate {
    
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        
        if connection == rVideoOutput?.connection(with: .video) {
            
            print("已采集视频画面")
            
        }else{
            print("已采集音频")
            
        }
        
    }
    
    
    
}


extension KLLiveController : AVCaptureFileOutputRecordingDelegate {
    
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]){
        
        print("开始写入文件")
    }
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        print("结束写入文件")
        
    }
    
    
}
