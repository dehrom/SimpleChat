//
//  Router.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

protocol EnteringModule: class {
    func openChatModule()
}

class EnteringRouter: EnteringModule {
    
    fileprivate var chatRouter: ChatModuleInput = ChatRouter()
    fileprivate var view: EnteringViewController!

    func openChatModule() {
        self.chatRouter.openChatModule(view)
    }

    func assembly(_ view: EnteringViewController) {
        self.view = view
        view.presenter = EnteringPresenter()
        (view.presenter as! EnteringPresenter).view = view
        (view.presenter as! EnteringPresenter).interactor = EnteringInteractor()
        ((view.presenter as! EnteringPresenter).interactor as! EnteringInteractor).presenter = (view.presenter as! EnteringInteractorOutput)
        (view.presenter as! EnteringPresenter).router = self
    }
    
}
