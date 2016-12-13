//
//  DTOToUserMessageMapper.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

class DTOToUserMessageMapper {

    func transform(_ model: MessageDTO) -> MessageViewModel {
        return MessageViewModel(text: model.content[0], cellType: .UserText)
    }

}
