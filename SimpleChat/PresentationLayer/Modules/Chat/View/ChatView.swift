//
//  ChatView.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import UIKit

protocol ChatViewInput: class, View {
    func enableSendButton(_ enable: Bool)
    func resetTextView()
    func inflateModel(_ model: [MessageViewModel])
}
