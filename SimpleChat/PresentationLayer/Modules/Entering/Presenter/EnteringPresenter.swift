//
//  EnteringPresenter.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

protocol EnteringPresenterInput: class {
    func validateNickname(_ text: String!)
    func enteringButtonDidTap()
}

//MARK: EnteringPresenterInput
class EnteringPresenter: EnteringPresenterInput {

    public var interactor: EnteringInteractorInput!
    public weak var view: EnteringView?
    public var router: EnteringRouter!
    fileprivate var nickName: String?
    fileprivate let validator = NicknameValidator()
    
    func enteringButtonDidTap() {
        interactor.startEnteringProcess(WithNickName: self.nickName!)
    }

    func validateNickname(_ text: String!) {
        let result = validator.validate(text)
        self.view?.enableButton(result)
        if result {
            self.nickName = text
        }
    }
    
}

//MARK: EnteringInteractorOutput
extension EnteringPresenter: EnteringInteractorOutput {

    func enteringProcessDidSuccess() {
        self.router.openChatModule()
    }
    
    func eteringProcessDidFail(WithError text: String) {
        self.view?.showErrorMessage(text)
    }
    
}
