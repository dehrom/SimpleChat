//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet fileprivate weak var _tableView: UITableView!
    @IBOutlet fileprivate weak var _bottomHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var _messageTextView: UITextView!
    @IBOutlet weak var _sendButton: UIButton!
    
    let router = ChatRouter()
    var presenter: ChatPresenterInput!
    let dataManager = DataDisplayManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.router.assembly(self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableTapped))
        self._tableView.addGestureRecognizer(tap)
        
        self._messageTextView.layer.borderColor = UIColor.gray.cgColor
        self._messageTextView.layer.cornerRadius = 10
        self._messageTextView.layer.borderWidth = 0.5
        
        self._sendButton.layer.borderColor = UIColor.blue.cgColor
        self._sendButton.layer.cornerRadius = 10
        self._sendButton.layer.borderWidth = 0.5
        
        self._tableView.delegate = self.dataManager
        self._tableView.dataSource = self.dataManager
        
        self._tableView.register(UINib(nibName: "UserMessageTableViewCell", bundle: nil), forCellReuseIdentifier: CellType.UserText.rawValue)
        self._tableView.register(UINib(nibName: "OpponentMessageTableViewCell", bundle: nil), forCellReuseIdentifier: CellType.OpponentText.rawValue)
        self._tableView.register(UINib(nibName: "OpponentNameTableViewCell", bundle: nil), forCellReuseIdentifier: CellType.OpponentName.rawValue)
        
        self._tableView.rowHeight = UITableViewAutomaticDimension
        self._tableView.estimatedRowHeight = 100
        self._tableView.separatorStyle = .none
        
        self._sendButton.isEnabled = false
    }

    func keyboardWillChangeFrame(note: NSNotification) {
        let keyboardAnimationDetail = note.userInfo!
        var keyboardFrame = (keyboardAnimationDetail[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.window?.convert(keyboardFrame, to: view) ?? keyboardFrame
        var chatInputOffset = ((self.view.bounds.height - self.bottomLayoutGuide.length) - keyboardFrame.minY) + 4
        chatInputOffset = max(chatInputOffset, 8)
        
        self._tableView.decelerationRate = UIScrollViewDecelerationRateFast
        self._bottomHeightLayoutConstraint.constant = chatInputOffset
        
        self.tableViewScrollToBottom()
        self._tableView.decelerationRate = UIWindowLevelNormal
    }
    
    
    func tableTapped() {
        self._messageTextView.endEditing(true)
    }
    
    //MARK: private
    
    
    fileprivate func tableViewScrollToBottom() {
        let numberOfSections = self._tableView.numberOfSections - 1
        
        if numberOfSections > -1 {
            let numberOfRows = self._tableView.numberOfRows(inSection: numberOfSections) - 1
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows, section: numberOfSections)
                self._tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    fileprivate func resolveMessageTextViewHeight() {
        let size = self._messageTextView.bounds.size
        let newSize = self._messageTextView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        let enabled = newSize.height > self._bottomHeightLayoutConstraint?.constant ?? 0
        
        self._messageTextView.isScrollEnabled = enabled
        self._messageTextView.showsVerticalScrollIndicator = enabled
        self._messageTextView.invalidateIntrinsicContentSize()
    }
    
}

//MARK: Actions
extension ChatViewController {

    @IBAction func _sendButtonDidTap(_ sender: UIButton) {
        self.presenter.senButtonDidTap()
    }
    
}

//MARK: UITextViewDelegate
extension ChatViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        self._messageTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.resolveMessageTextViewHeight()
        self.presenter.validateMessage(textView.text)
    }
    
}

//MARK: ChatViewInput
extension ChatViewController: ChatViewInput {
    
    func enableSendButton(_ enable: Bool) {
        self._sendButton.isEnabled = enable
    }
    
    func resetTextView() {
        self._messageTextView.text = nil
        self.resolveMessageTextViewHeight()
        self.tableViewScrollToBottom()
    }

    func inflateModel(_ model: [MessageViewModel]) {
        self.dataManager.inflateModel(model)
        self._tableView.reloadData()
        self.tableViewScrollToBottom()
    }
    
    func showErrorMessage(_ text: String) {
        self.showAlertViewController(WithTitle: "Ошибка", Message: text)
    }

}
