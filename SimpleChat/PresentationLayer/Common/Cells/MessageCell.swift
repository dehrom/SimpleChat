//
//  BaseTableViewCell.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import UIKit

protocol MessageCell: class {
    func setModel(_ model: MessageViewModel)
}
