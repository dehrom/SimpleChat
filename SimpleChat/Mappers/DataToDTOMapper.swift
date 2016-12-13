//
//  DataToDTOMapper.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

class DataToDTOMapper {

    func  transform(_ response: [UInt8]) -> MessageDTO {
        let message = String.init(bytes: response, encoding: .utf8)!
        let separatedMessageString = message.components(separatedBy: ":")
        let sender = separatedMessageString[0]
        var messages = separatedMessageString[1].components(separatedBy: ",")
        
        messages = messages.flatMap { (message) -> String in
            let newMessage = message.replacingOccurrences(of: "\\", with: "")
            return newMessage
        }
        
        return MessageDTO(sender: SenderModel(name: sender), content: messages)
    }
    
}
