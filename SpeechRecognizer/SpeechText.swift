//
//  SpeechText.swift
//  SpeechRecognizer
//
//  Created by Dayton Steffeny on 8/30/19.
//  Copyright © 2019 Dayton Steffeny. All rights reserved.
//

import Foundation
import UIKit
import Speech

extension ViewController{
    
    func startRecording() throws {
        
        if task != nil {
           task?.cancel()
           task = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .measurement, options: .interruptSpokenAudioAndMixWithOthers)
           
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        ask = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEng.inputNode
        guard let ask = ask else
        {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        ask.shouldReportPartialResults = true
        
        task = speechRecognizer?.recognitionTask(with: ask, resultHandler: { (result, error) in
            var isFinal = false
            if(result?.bestTranscription.formattedString != nil){
                DispatchQueue.main.async {
                    self.textViewer.text =  (result?.bestTranscription.formattedString)!}
                
            }
            
            if(result?.isFinal != nil)
            {  isFinal = (result?.isFinal)!}
            
            if isFinal || error != nil {
                let command = result?.bestTranscription.formattedString
            
                if command != nil
                {
                    self.audioEng.inputNode.removeTap(onBus: 0)
                    self.audioEng.stop()
                    self.ask?.endAudio()
                    
                }
                
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.ask?.append(buffer)
        }
        audioEng.prepare()
        try audioEng.start()
    }
    
    
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        
        if available {
            beginButton.isEnabled = true
            beginButton.setTitle("Start Recording", for: [])
        } else {
            beginButton.isEnabled = false
            beginButton.setTitle("Recognition not available", for: .disabled)
        }
    }
    
}
