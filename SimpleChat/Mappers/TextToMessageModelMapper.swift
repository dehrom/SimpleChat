//
//  TextToMessageModelMapper.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

class TextToMessageModelMapper {
    
    func transform(_ text: String) -> MessageViewModel {
        return MessageViewModel(text: text, cellType: .UserText)
    }

}
