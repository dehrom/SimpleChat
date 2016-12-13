//
//  ChatInteractor.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

protocol ChatInteractorInput: class {
    func sendMessage(_ model: MessageViewModel)
}

protocol ChatInteractorOutput: class {
    func didReceivedMessage(_ message: [MessageViewModel])
    func didSendMessage(_ model: [MessageViewModel])
    func didSendMessageFail(WithError text: String)
}

class ChatInteractor: ChatInteractorInput {
    
    public var presenter: ChatInteractorOutput!
    fileprivate let service = SenderService()
    fileprivate let messageFromDTOMapper = MessageFromDTOMapper()
    fileprivate let messageToDTOMapper = MessageToDTOMapper()
    fileprivate let userMessageFromDTOMapper = DTOToUserMessageMapper()
    fileprivate let userDefaults = UserDefaults.standard

    
    init() {
        self.service.delegate = self
    }
    
    func sendMessage(_ model: MessageViewModel) {
        guard let userNickname = self.userDefaults.string(forKey: Constants.UserLoginKey) else {
            self.presenter.didSendMessageFail(WithError: Constants.DefaultSendMessageErrorText)
            return
        }
        
        let dtoModel = self.messageToDTOMapper.transform(userNickname, model)
        self.service.sendMessage(dtoModel)
    }
    
}

//MARK: SenderServiceDelegate
extension ChatInteractor: SenderServiceDelegate {
    
    func didReceiveMessage(_ model: MessageDTO) {
        let viewModel = self.messageFromDTOMapper.transfrom(model)
        self.presenter.didReceivedMessage(viewModel)
    }
    
    func didSendMessageSuccess(_ model: MessageDTO) {
        let viewModel = self.userMessageFromDTOMapper.transform(model)
        self.presenter.didSendMessage([viewModel])
    }
    
    func didSendMessageFail(_ model: MessageDTO) {
        self.presenter.didSendMessageFail(WithError: Constants.DefaultSendMessageErrorText)
    }
    
}
