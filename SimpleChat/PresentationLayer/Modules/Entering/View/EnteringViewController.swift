//
//  ViewController.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import UIKit

class EnteringViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet fileprivate weak var _enteringButton: UIButton?
    @IBOutlet fileprivate weak var _nickName: UITextField?
    
    var presenter: EnteringPresenterInput?
    var router: EnteringRouter = EnteringRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.router.assembly(self)
        
        self._nickName?.layer.borderWidth = 2.0
        self._nickName?.layer.cornerRadius = 5.0
        self._nickName?.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        
        self._enteringButton?.layer.borderWidth = 2.0
        self._enteringButton?.layer.cornerRadius = 5.0
        self._enteringButton?.layer.borderColor = UIColor.blue.withAlphaComponent(0.2).cgColor
        self._enteringButton?.isEnabled = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self._nickName?.endEditing(true)
    }
    
}

//MARK: Actions
extension EnteringViewController {
    
    @IBAction func editingChanged(_ sender: UITextField) {
        self.presenter?.validateNickname(self._nickName?.text)
    }

    @IBAction func _enteringButtonDidTap(_ sender: UIButton) {
        self.presenter?.enteringButtonDidTap()
    }
    
}

//MARK: EnteringView
extension EnteringViewController: EnteringView {

    func enableButton(_ enabled: Bool) {
        _enteringButton?.isEnabled = enabled
    }
    
    func showErrorMessage(_ text: String) {
        showAlertViewController(WithTitle: "Ошибка", Message: text)
    }
    
}
