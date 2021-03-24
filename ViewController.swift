//
//  ViewController.swift
//  UIHostingTableViewTest
//
//  Created by Costantino Pistagna on 24/03/21.
//

import UIKit
import SwiftUI

class ViewController: UITableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? CustomTableViewCell {
            cell.configure(title: "IndexPathRow \(indexPath.row)", sfIcon: "pencil.and.outline")
            return cell
        }
        return UITableViewCell()
    }
}
