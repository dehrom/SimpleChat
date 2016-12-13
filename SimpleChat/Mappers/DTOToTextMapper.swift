//
//  DTOToTextMapper.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

class DTOToTextMapper {

    func transform(_ model: MessageDTO) -> String {
        return String(format: "%@:\\%@\\", model.sender.name, model.content[0])
    }
    
}
