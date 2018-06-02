//
//  BaseCell.swift
//  ViewTube
//
//  Created by Devesh Nema on 6/1/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
