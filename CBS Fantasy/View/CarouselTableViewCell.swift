//
//  GalleryTableViewCell.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import UIKit

protocol CarouselTableViewCellDelegate: class {
    
    func numberOfCells(for rowIndex: Int) -> Int
    func cellForItem(at index: Int, for collectionView: UICollectionView, on rowIndex: Int) -> UICollectionViewCell
    func didSelectItem(at index: Int, on rowIndex: Int)
}

class CarouselTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var allButton: UIButton!
    fileprivate weak var delegate: CarouselTableViewCellDelegate?
    var rowIndex: Int = -1
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: self.frame.size.width * 0.9, height: ((self.frame.size.width * 0.9 * 9.0/16.0) + 34.0))
    }
    
    func setup(for delegate: CarouselTableViewCellDelegate, index: Int, title: String, allButtonTitle: String?) {
        self.delegate = delegate
        self.rowIndex = index
        self.title.text = title
        
        if allButtonTitle != nil {
            allButton.setTitle(allButtonTitle, for: .normal)
        } else {
            allButton.isHidden = true
        }
    }

    @IBAction func allButtonAction(_ sender: Any) {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        allButton.setTitle("", for: .normal)
        rowIndex = -1
        delegate = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: self.frame.size.width * 0.9, height: ((self.frame.size.width * 0.9 * 9.0/16.0) + 34.0))
        collectionView.reloadData()
    }
}

extension CarouselTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return delegate?.cellForItem(at: indexPath.item, for: collectionView, on: self.rowIndex) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfCells(for: self.rowIndex) ?? 0
    }
}

extension CarouselTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.item, on: self.rowIndex)
    }
    
    
}
