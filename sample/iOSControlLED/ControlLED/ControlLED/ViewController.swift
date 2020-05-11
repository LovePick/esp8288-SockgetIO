//
//  ViewController.swift
//  ControlLED
//
//  Created by Supapon Pucknavin on 10/5/2563 BE.
//  Copyright © 2563 Supapon Pucknavin. All rights reserved.
//

import UIKit
import SocketIO


class ViewController: UIViewController {

    
    enum TagSlider:NSInteger{
        case red = 0
        case green
        case blue
    }
    
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    
    
    var manager:SocketManager! = nil
    var socket:SocketIOClient! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sliderRed.value = 0
        sliderBlue.value = 0
        sliderGreen.value = 0
        
        self.updateColor()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.connectToServer()
    }
    
    
    func connectToServer(){
        
        let strURL:String = "http://192.168.2.66:5000" //"http://localhost:5000"
        guard let url = URL(string: strURL) else { return }
        
    
        self.manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
        
        
        self.socket.on(clientEvent: .connect) { (data, ack) in
            
            print("socket connected")
        }
        
        
        self.socket.on(clientEvent: .disconnect) { (data, ack) in
            
            print("socket disconnected")
        }
        
        
        self.socket.connect()
        
        
    }
    
    
    

    
    
    
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        
        self.updateColor()
        self.sendMessageToServer()
        
    }
    
    
    func updateColor(){
        self.view.backgroundColor = UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: 1.0)
    }
    

    func sendMessageToServer(){
        let myColor:LEDMessageDataModel = LEDMessageDataModel()
        
        myColor.r = CGFloat(sliderRed.value)
        myColor.g = CGFloat(sliderGreen.value)
        myColor.b = CGFloat(sliderBlue.value)
        
        self.socket.emit("message", myColor.getDictionary())
    }
}

