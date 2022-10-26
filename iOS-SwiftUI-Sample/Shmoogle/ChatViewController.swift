//
//  ChatViewController.swift
//  Shmoogle
//
//  Created by Tehila rozin on 19/09/2022.
//

import Foundation
import UIKit
import GenesysCloud

class ShmoogViewController: UIViewController, ChatControllerDelegate {

    var chatController: ChatController!
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        let messengerAccount = MessengerAccount()
        messengerAccount.deploymentId =  "f6dd00eb-349b-4f12-95a4-9bdd24ee607c"
            messengerAccount.domain = "inindca.com"
            messengerAccount.tokenStoreKey = "com.genesys.messenger.poc"

        view.backgroundColor = UIColor(red: 255/255, green: 79/255, blue: 30/255, alpha: 0.5) //UIColor(red: 255 / 255, green: 79 / 255, blue: 30 / 255, alpha: 1)
        
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        view.insetsLayoutMarginsFromSafeArea = false
        
        self.chatController = ChatController(account: messengerAccount)
        chatController.delegate = self
    }

    @objc func dismissChat(_ sender: UIBarButtonItem?) {
        self.chatController.terminate()
        presentingViewController?.dismiss(animated: false)
    }
    
    func shouldPresentChatViewController(_ viewController: UINavigationController!) {
        
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = .white
            self.activityIndicator.alpha = 0
        } completion: { _ in
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: false) { () -> Void in
                viewController.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "End Chat", style: .plain, target: self, action: #selector(ShmoogViewController.dismissChat(_:)))
            }

        }

    }

    func didFailWithError(_ error: BLDError!) {
        print(error.error.debugDescription);
    }
}
