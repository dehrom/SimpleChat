//
//  NicknameValidator.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

class NicknameValidator {

    func validate(_ text: String) -> Bool {
        return !text.isEmpty && !(text.hasPrefix(" ") || text.hasSuffix(" "))
    }
    
}
