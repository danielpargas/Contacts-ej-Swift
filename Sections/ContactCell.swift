//
//  ContactCell.swift
//  Sections
//
//  Created by aviezer group on 23/11/17.
//  Copyright © 2017 aviezer group. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {
    
    var delegate: ContactsCellProtocol?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        backgroundColor = .red

        // kind of cheat and use hack
        
        let starButton = UIButton(type: .system)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.setImage(#imageLiteral(resourceName: "ic_star"), for: .normal)
        
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
    }
    
    
    @objc private func handleMarkAsFavorite() {
        print("Marking as favorite")
        delegate?.touchFavoriteMark(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) Not implement")
    }
    
    
}

protocol ContactsCellProtocol {
    func touchFavoriteMark(cell: ContactsCell)
}

