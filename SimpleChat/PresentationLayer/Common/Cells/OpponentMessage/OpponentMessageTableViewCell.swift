//
//  OpponentMessageTableViewCell.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import UIKit

class OpponentMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var _messageText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self._messageText.layer.cornerRadius = 10
        self._messageText.layer.borderWidth = 1.0
        self._messageText.layer.borderColor = UIColor.gray.cgColor
    }
    
}

extension OpponentMessageTableViewCell: MessageCell {

    func setModel(_ model: MessageViewModel) {
        self._messageText.text = model.text
    }
    
}
