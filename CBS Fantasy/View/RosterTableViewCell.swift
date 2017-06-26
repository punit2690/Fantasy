//
//  RosterTableViewCell.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import UIKit

protocol RosterTableViewCellDelegate: class {
    func numberOfSectionsInRosterCell(for index: Int) -> Int
    func numberOfRowsInRosterCell(in section: Int, for rowIndex: Int) -> Int
    func cellForRowInRosterCell(at indexpath: IndexPath, for rowIndex: Int, from tableView: UITableView) -> UITableViewCell
    func viewForHeaderInRosterCell(in section: Int, for rowIndex: Int) -> UIView
}

typealias PlayerUpdatestableViewCell = RosterTableViewCell

class RosterTableViewCell: UITableViewCell {

    @IBOutlet private weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            tableView.estimatedRowHeight = 60
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var allButton: UIButton!
    weak var delegate: RosterTableViewCellDelegate?
    var rowIndex: Int = -1

    func setup(for delegate: RosterTableViewCellDelegate, index rowIndex: Int, title: String, allButtonTitle: String?) {
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
            for i in 1...delegate.numberOfSectionsInRosterCell(for: self.rowIndex) {
                tableViewHeight = tableViewHeight + 30 + Double (delegate.numberOfRowsInRosterCell(in: i-1, for: self.rowIndex)) * 88.0
            }
            self.tableviewHeight!.constant = CGFloat(tableViewHeight)
        layoutIfNeeded()
    }
}

extension RosterTableViewCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.numberOfSectionsInRosterCell(for: self.rowIndex) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfRowsInRosterCell(in: section, for: self.rowIndex) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate?.cellForRowInRosterCell(at: indexPath, for: self.rowIndex, from: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return delegate?.viewForHeaderInRosterCell(in: section, for: self.rowIndex) ?? UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension RosterTableViewCell: UITableViewDelegate {
    
}
