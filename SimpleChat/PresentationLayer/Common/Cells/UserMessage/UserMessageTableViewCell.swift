//
//  UserMessageTableViewCell.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import UIKit

class UserMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var _messageText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self._messageText.layer.cornerRadius = 10
        self._messageText.layer.borderWidth = 1.0
        self._messageText.layer.borderColor = UIColor.green.withAlphaComponent(0.25).cgColor
        
    }

}

extension UserMessageTableViewCell: MessageCell {
    
    func setModel(_ model: MessageViewModel) {
        self._messageText.text = model.text
    }
    
}
