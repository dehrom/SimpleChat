//
//  MessageDTOMapper.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

class MessageFromDTOMapper {

    func transfrom(_ model: MessageDTO) -> [MessageViewModel] {
        var data = [MessageViewModel]()
        
        if !model.sender.name.isEmpty {
            data.append(self.transformToOpponentName(model.sender))
        }
        
        for text in model.content {
            data.append(self.transformToDialogMessage(text))
        }
        
        return data
    }

    
    fileprivate func transformToOpponentName(_ model: SenderModel) -> MessageViewModel {
        return MessageViewModel(text: model.name, cellType: .OpponentName)
    }
    
    fileprivate func transformToDialogMessage(_ text: String) -> MessageViewModel {
        return MessageViewModel(text: text, cellType: .OpponentText)
    }
    
}
