//
//  Extensions.swift
//  ViewTube
//
//  Created by Devesh Nema on 6/2/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


