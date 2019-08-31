//
//  Authorized.swift
//  SpeechRecognizer
//
//  Created by Dayton Steffeny on 8/30/19.
//  Copyright © 2019 Dayton Steffeny. All rights reserved.
//

import Foundation
import Speech

extension ViewController{
    
    func requestAuthorization(){
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.beginButton.isEnabled = true //if the user grants access to the mic
                    
                case .denied:
                    self.beginButton.isEnabled = false
                    self.beginButton.setTitle("User denied access to speech recognition", for: .disabled) // if the user does not grant access to the mic
                    
                case .restricted:
                    self.beginButton.isEnabled = false
                    self.beginButton.setTitle("Speech recognition restricted on this device", for: .disabled) // if the device has restricted access to the mic
                    
                case .notDetermined:
                    self.beginButton.isEnabled = false
                    self.beginButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                    // if the unsure what the issue is with not gaining access to the mic
                }
            }
        }
    }
    
}
