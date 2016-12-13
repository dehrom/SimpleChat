//
//  SenderService.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

protocol SenderServiceDelegate: class {
    func didReceiveMessage(_ model: MessageDTO)
    func didSendMessageSuccess(_ model: MessageDTO)
    func didSendMessageFail(_ model: MessageDTO)
}

class SenderService {
    
    public weak var delegate: SenderServiceDelegate?
    fileprivate let connection = UDPBroadcastConnection(port: Constants.ConnectionPort)
    fileprivate let dataMapper = DataToDTOMapper()
    fileprivate let modelMapper = DTOToTextMapper()
    
    init() {
        self.connection.setHandler { (_, _, response) in
            let model = self.dataMapper.transform(response)
            self.delegate?.didReceiveMessage(model)
        }
    }
    
    deinit {
        self.connection.closeConnection()
    }
    
    func sendMessage(_ model: MessageDTO) {
        let message = self.modelMapper.transform(model)
        self.connection.sendBroadcast(message)
        self.delegate?.didSendMessageSuccess(model)
        
        #if DEBUG
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.delegate?.didReceiveMessage(model)
            }
        #endif
    }

}
