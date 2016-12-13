//
//  DataDisplayManager.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import UIKit

class DataDisplayManager: NSObject {
    
    fileprivate var data = [MessageViewModel]()
    
    func inflateModel(_ model: [MessageViewModel]) {
        self.data += model
    }
    
}

//MARK: UITableViewDelegate
extension DataDisplayManager: UITableViewDelegate {

}

//MARK: UITableViewDataSource
extension DataDisplayManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellType.rawValue)!
        (cell as! MessageCell).setModel(model)
        return cell
    }
    
}
