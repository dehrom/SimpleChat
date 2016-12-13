//
//  MessageToDTOMapper.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

class MessageToDTOMapper {

    func transform(_ sender: String, _ model: MessageViewModel) -> MessageDTO {
        return MessageDTO(sender: SenderModel(name: sender), content: [model.text])
    }
    
}
