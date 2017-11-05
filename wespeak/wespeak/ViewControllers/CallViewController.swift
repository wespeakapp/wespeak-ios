//
//  CallViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/25/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import OpenTok

// Replace with your OpenTok API key
let kApiKey = "45969452"
// Replace with your generated session ID
var kSessionId = ""
// Replace with your generated token
var kToken = ""

let kWidgetHeight = 180
let kWidgetWidth = 140

class CallViewController: UIViewController {

    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet var subscriberView: UIView!
    @IBOutlet weak var publisherView: UIView!
    var conversation: Conversation! {
        didSet {
            kSessionId = conversation.sessionId
            kToken = conversation.token
        }
    }
    
    var session: OTSession!
    
    lazy var publisher: OTPublisher = {
        let settings = OTPublisherSettings()
        settings.name = UIDevice.current.name
        return OTPublisher(delegate: self, settings: settings)!
    }()
    
    var subscriber: OTSubscriber?
    
    // Change to `false` to subscribe to streams other than your own.
    var subscribeToSelf = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMatchedPopup()
    }
    
    func showMatchedPopup() {
        let popup = MatchedPopup(frame: CGRect(x: 0, y: 0, width: Screen.size.width, height: Screen.size.height))
        self.view.addSubview(popup)
        popup.partner = conversation.partner
        popup.delegate = self
    }
    
    @IBAction func turnoffMicAction(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        } else {
            sender.isSelected = false
        }
    }
    
    @IBAction func turnoffCameraAction(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        } else {
            sender.isSelected = false
        }
    }
    
    @IBAction func endCallAction(_ sender: UIButton) {
        let popup = EndCallPopup(frame:  CGRect(x: 0, y: 0, width: Screen.size.width, height: Screen.size.height))
        popup.delegate = self
        view.addSubview(popup)
    }
    
    /**
     * Asynchronously begins the session connect process. Some time later, we will
     * expect a delegate method to call us back with the results of this action.
     */
    
    fileprivate func doConnect() {
        
        session =  OTSession(apiKey: kApiKey, sessionId: kSessionId, delegate: self)!
        var error: OTError?
        defer {
            processError(error)
        }
        
        session.connect(withToken: kToken, error: &error)
    }
    
    fileprivate func doPublish() {
        var error: OTError?
        defer {
            processError(error)
        }
        
        session.publish(publisher, error: &error)
        
        if let pubView = publisher.view {
            pubView.frame = CGRect(x: 0, y: 0, width: publisherView.frame.width, height:  publisherView.frame.height)
            publisherView.addSubview(pubView)
        }
    }

    fileprivate func doSubscribe(_ stream: OTStream) {
        var error: OTError?
        defer {
            processError(error)
        }
        subscriber = OTSubscriber(stream: stream, delegate: self)
        
        session.subscribe(subscriber!, error: &error)
    }
    
    fileprivate func cleanupSubscriber() {
        subscriber?.view?.removeFromSuperview()
        subscriber = nil
    }
    
    fileprivate func processError(_ error: OTError?) {
        if let err = error {
            DispatchQueue.main.async {
                let controller = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func getConversationBy(id: String) {
        APIManager.shareInstance.getConversationInfo(id: id, completionHandle: {
            result in
            switch result {
            case .success(let conversation):
                self.conversation = conversation
                self.doConnect()
                break
            case .failure(let error):
                print(error.message)
                break
            }
        })
    }
}

extension CallViewController: MatchedPopupDelegate {
    func start() {
        getConversationBy(id: conversation.id)
    }
}

extension CallViewController: EndCallPopupDelegate {
    func endCall() {
        performSegue(withIdentifier: "ReviewVCSegue", sender: self)
    }
}

extension CallViewController: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
        print("Session connected")
        doPublish()
    }
    
    func sessionDidDisconnect(_ session: OTSession) {
        print("Session disconnected")
    }
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {
        print("Session streamCreated: \(stream.streamId)")
        if subscriber == nil && !subscribeToSelf {
            doSubscribe(stream)
        }
    }
    
    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
        print("Session streamDestroyed: \(stream.streamId)")
        if let subStream = subscriber?.stream, subStream.streamId == stream.streamId {
            cleanupSubscriber()
        }
    }
    
    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("session Failed to connect: \(error.localizedDescription)")
    }
    
}

// MARK: - OTPublisher delegate callbacks
extension CallViewController: OTPublisherDelegate {
    func publisher(_ publisher: OTPublisherKit, streamCreated stream: OTStream) {
        if subscriber == nil && subscribeToSelf {
            doSubscribe(stream)
        }
    }
    
    func publisher(_ publisher: OTPublisherKit, streamDestroyed stream: OTStream) {
        if let subStream = subscriber?.stream, subStream.streamId == stream.streamId {
            cleanupSubscriber()
        }
    }
    
    func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
        print("Publisher failed: \(error.localizedDescription)")
    }
}

// MARK: - OTSubscriber delegate callbacks
extension CallViewController: OTSubscriberDelegate {
    func subscriberDidConnect(toStream subscriberKit: OTSubscriberKit) {
        
    }
    
    func subscriberVideoDataReceived(_ subscriber: OTSubscriber) {
        if let subsView = subscriber.view {
            subsView.frame = CGRect(x: 0, y: 0, width: subscriberView.frame.width, height: subscriberView.frame.height)
            subscriberView.addSubview(subsView)
        }
    }
    
    func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
        print("Subscriber failed: \(error.localizedDescription)")
    }
}
