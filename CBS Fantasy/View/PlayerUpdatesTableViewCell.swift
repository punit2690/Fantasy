//
//  RosterTableViewCell.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/26/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import UIKit

protocol PlayerUpdatesTableViewCellDelegate: class {
    func numberOfRows(for rowIndex: Int) -> Int
    func cellForRow(at indexpath: Int, for rowIndex: Int, from tableView: UITableView) -> UITableViewCell
}

class PlayerUpdatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            //tableView.estimatedRowHeight = 60
            //tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var allButton: UIButton!
    weak var delegate: PlayerUpdatesTableViewCellDelegate?
    var rowIndex: Int = -1
    
    func setup(for delegate: PlayerUpdatesTableViewCellDelegate, index rowIndex: Int, title: String, allButtonTitle: String?) {
        self.delegate = delegate
        self.rowIndex = rowIndex
        self.title.text = title
        
        if allButtonTitle != nil {
            allButton.setTitle(allButtonTitle, for: .normal)
        } else {
            allButton.isHidden = true
        }
        layoutIfNeeded()
        var tableViewHeight = 0.0
        tableViewHeight = tableViewHeight + Double (delegate.numberOfRows(for: self.rowIndex)) * 88.0
        self.tableviewHeight!.constant = CGFloat(tableViewHeight)
        layoutIfNeeded()
    }
}

extension PlayerUpdatesTableViewCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfRows(for: self.rowIndex) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate?.cellForRow(at: indexPath.row, for: self.rowIndex, from: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
