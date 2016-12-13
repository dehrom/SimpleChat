//
//  ChatRouter.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import UIKit

protocol ChatModuleInput: class {
    func openChatModule(_ parentVC: UIViewController)
}

class ChatRouter: ChatModuleInput {
    
    func openChatModule(_ parentVC: UIViewController) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let chatVC = storyboard.instantiateInitialViewController()!
        parentVC.show(chatVC, sender: parentVC)
    }
    
    func assembly(_ view: ChatViewController) {
        view.presenter = ChatPresenter()
        (view.presenter as! ChatPresenter).view = view
        (view.presenter as! ChatPresenter).interactor = ChatInteractor()
        ((view.presenter as! ChatPresenter).interactor as! ChatInteractor).presenter = (view.presenter as! ChatPresenter)
    }
    
}
