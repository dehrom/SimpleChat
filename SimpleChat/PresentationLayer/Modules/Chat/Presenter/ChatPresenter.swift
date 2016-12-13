//
//  ChatPresenter.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

protocol ChatPresenterInput: class {
    func validateMessage(_ text: String)
    func senButtonDidTap()
}

class ChatPresenter: ChatPresenterInput {
    
    public weak var view: ChatViewInput?
    public var interactor: ChatInteractorInput?
    
    fileprivate let validator = StringValidator()
    fileprivate var message: String!
    fileprivate let textToMessageMapper = TextToMessageModelMapper()

    func validateMessage(_ text: String) {
        let result = validator.validate(text)
        if result {
            self.message = text
        }
        self.view?.enableSendButton(result)
    }
    
    func senButtonDidTap() {
        let message = self.message.trimmingCharacters(in: .whitespacesAndNewlines)
        let viewModel = self.textToMessageMapper.transform(message)
        self.interactor?.sendMessage(viewModel)
    }

}

//MARK: ChatInteractorOutput
extension ChatPresenter: ChatInteractorOutput {
    
    func didReceivedMessage(_ model: [MessageViewModel]) {
        self.view?.inflateModel(model)
    }
    
    func didSendMessage(_ model: [MessageViewModel]) {
        self.view?.inflateModel(model)
        self.view?.resetTextView()
        self.message = nil
        self.view?.enableSendButton(false)
    }
    
    func didSendMessageFail(WithError text: String) {
        self.view?.showErrorMessage(text)
    }

}
