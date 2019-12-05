//
//  PlayerView.swift
//  TeamUp
//
//  Created by Quy Cao on 12/5/19.
//  Copyright © 2019 Quy Cao. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    
    var player: Player
    
    var nameLabel: UILabel!
    
    struct Settings {
        static let defaultSize = CGSize(width: 80, height: 80)
        static let tintColor = UIColor(red: 0.000, green: 0.479, blue: 0.999, alpha: 1.00)
        static let font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    init(player: Player) {
        self.player = player
        
        var defaultFrame = CGRect.zero
        defaultFrame.size = Settings.defaultSize
        
        super.init(frame: defaultFrame)
        
        setupUI()
        setupMembers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerView {
    
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = Settings.defaultSize.width / 2
        layer.borderColor = Settings.tintColor.cgColor
        layer.borderWidth = 1
        backgroundColor = UIColor.systemGroupedBackground
    }
    
    private func setupMembers() {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = Settings.tintColor
        label.font = Settings.font
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        label.text = player.name
        
        nameLabel = label
    }
}
