//
//  EnteringInteractor.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

protocol EnteringInteractorInput: class {
    func startEnteringProcess(WithNickName text: String)
}

protocol EnteringInteractorOutput: class {
    func enteringProcessDidSuccess()
    func eteringProcessDidFail(WithError text: String)
}

class EnteringInteractor: EnteringInteractorInput {
    
    let userDefaults = UserDefaults.standard
    var presenter: EnteringInteractorOutput?
    
    //MARK: EnteringInteractorInput
    internal func startEnteringProcess(WithNickName text: String) {
        self.userDefaults.setValue(text, forKey: Constants.UserLoginKey)
        self.userDefaults.synchronize()
        
        guard userDefaults.string(forKey: Constants.UserLoginKey) != nil else {
            self.presenter?.eteringProcessDidFail(WithError: "Не удалось сохранить имя пользователя")
            return
        }
        
        self.presenter?.enteringProcessDidSuccess()
    }

}
