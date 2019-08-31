//
//  ViewController.swift
//  SpeechRecognizer
//
//  Created by Dayton Steffeny on 8/30/19.
//  Copyright © 2019 Dayton Steffeny. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController,SFSpeechRecognizerDelegate
{
    
   var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    var ask: SFSpeechAudioBufferRecognitionRequest?
    var task: SFSpeechRecognitionTask?
    let audioEng = AVAudioEngine()
    
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var textViewer: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool)
    {
        speechRecognizer?.delegate = self
        requestAuthorization()
    }
    
  
    @IBAction func BeginButtonPressed(_ sender: Any)
    {
    
    
        if  audioEng.isRunning
        {
            ask?.shouldReportPartialResults = false
            audioEng.inputNode.removeTap(onBus: 0)
            audioEng.stop()
            ask?.endAudio()
            
            
            beginButton.isEnabled = true
            beginButton.setTitle("Begin Recording", for: [])
            
        } else {
            
            try! startRecording()
            
            beginButton.setTitle("Stop Recording", for: [])
        }
    }
    
    
}
    
    
    
    
    


