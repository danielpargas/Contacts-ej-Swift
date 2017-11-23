//
//  ExpandableNames.swift
//  Sections
//
//  Created by aviezer group on 22/11/17.
//  Copyright © 2017 aviezer group. All rights reserved.
//

import Foundation

struct ExpandableNames {
    
    var isExpanded: Bool
    var names: [Contact]
    
}

struct Contact {
    let name: String
    var hasFavorited: Bool
}
