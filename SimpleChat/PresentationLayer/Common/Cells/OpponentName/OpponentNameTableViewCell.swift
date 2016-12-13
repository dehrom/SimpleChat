//
//  OpponentNameTableViewCell.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import UIKit

class OpponentNameTableViewCell: UITableViewCell {
    @IBOutlet weak var _name: UILabel!
}

extension OpponentNameTableViewCell: MessageCell {

    func setModel(_ model: MessageViewModel) {
        self._name.text = model.text
    }
    
}
