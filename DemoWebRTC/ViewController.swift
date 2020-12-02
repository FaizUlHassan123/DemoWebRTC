//
//  ViewController.swift
//  DemoWebRTC
//
//  Created by Faiz Ul Hassan on 02/12/2020.
//

//
//  JitsVideoCallViewController.swift
//  doctor
//
//  Created by Faiz Ul Hassan on 9/8/20.
//  Copyright © 2020 Techsole. All rights reserved.
//

import UIKit
import JitsiMeet

class JitsVideoCallViewController: UIViewController {

    
    @IBOutlet weak var videoButton: UIButton?
    @IBOutlet weak var roomName: UITextField!
    var room_name:String = ""
    
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomName.layer.cornerRadius = 12
        roomName.layer.masksToBounds = true
        roomName.layer.borderWidth = 1
        roomName.layer.borderColor = UIColor.lightGray.cgColor
        videoButton?.layer.cornerRadius = 18
        videoButton?.layer.masksToBounds = true
    }

    @IBAction func openJitsiMeet(sender: Any?) {
        let room: String = roomName.text!
        if(room.count < 1) {
            print("return")
            return
        }

        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.welcomePageEnabled = false
            builder.room = room
        }

        // setup view controller
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view = jitsiMeetView

        // join room and display jitsi-call
        jitsiMeetView.join(options)
        present(vc, animated: true, completion: nil)
        
    }
    

    fileprivate func cleanUp() {
        if(jitsiMeetView != nil) {
            dismiss(animated: true, completion: nil)
            jitsiMeetView = nil
        }
    }
    
}


extension JitsVideoCallViewController: JitsiMeetViewDelegate {
    
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        cleanUp()
        print("Conference termibated")
        print(data as Any)
    }
    
    func conferenceJoined(_ data: [AnyHashable : Any]!) {
        print("Conference joined")
        print(data as Any)
    }
    
    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        print("Picture in Picture")
        print(data as Any)
    }
}
