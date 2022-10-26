//
//  ShmoogleApp.swift
//  Shmoogle
//
//  Created by Tehila rozin on 19/09/2022.
//

import SwiftUI
import GenesysCloud

/*class CCAppDelegate: NSObject, UIApplicationDelegate, ChatControllerDelegate {
 
    var chatController : ChatController
    
    func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // ...
    return true
  }
    
    func createController(){
        let messengerAccount = MessengerAccount()
        messengerAccount.deploymentId =  "f6dd00eb-349b-4f12-95a4-9bdd24ee607c"
            messengerAccount.domain = "inindca.com"
            messengerAccount.tokenStoreKey = "com.genesys.messenger.poc"
        
        chatController = ChatController(account: messengerAccount)
        chatController.delegate = self
        
    }
    
    func terminate(){
        self.chatController.terminate()
    }
    
    func shouldPresentChatViewController(_ viewController: UINavigationController!) {
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true) { () -> Void in
                viewController.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "End Chat", style: .plain, target: self, action: #selector(ViewController.dismissChat(_:)))
            }
        }

        func didFailWithError(_ error: BLDError!) {
            print(error.error.debugDescription);
        }
}*/


@main
struct ShmoogleApp: App {
    //@UIApplicationDelegateAdaptor var delegate: CCAppDelegate
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()//.onAppear(perform: createController).onDisappear(perform: delegate.terminate)
        }
    }
    
//    func createController(){
//        delegate.createController()
//    }
    
    
}


