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
    var avatarImageView: UIImageView!
    
    struct Settings {
        static let defaultSize = CGSize(width: 80, height: 80)
        static let tintColor = UIColor(red: 0.000, green: 0.479, blue: 0.999, alpha: 1.00)
        static let font = UIFont.boldSystemFont(ofSize: 18)
        static let animationDuration: TimeInterval = 0.3
    }
    
    init(player: Player) {
        self.player = player
        
        var defaultFrame = CGRect.zero
        defaultFrame.size = Settings.defaultSize
        
        super.init(frame: defaultFrame)
        
        setupUI()
        setupNameLabel()
        setupAvatarImageView()
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
    
    private func setupNameLabel() {
        let name = UILabel(frame: CGRect.zero)
        name.textAlignment = .center
        name.textColor = Settings.tintColor
        name.font = Settings.font
        
        addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor).isActive = true
        name.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
//        name.text = player.name
        
        nameLabel = name
    }
    
    private func setupAvatarImageView() {
        let avatar = UIImageView(frame: CGRect.zero)
        avatar.contentMode = .scaleAspectFill
        avatar.backgroundColor = UIColor.clear
        
        addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        avatar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        avatar.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        avatar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        avatar.image = UIImage(named: player.id)
        
        avatarImageView = avatar
    }
}

extension PlayerView {
    func showInfo() {
        UIView.animate(withDuration: Settings.animationDuration) { [weak self] in
            self?.nameLabel.alpha = 1.0
            self?.avatarImageView.alpha = 1.0
        }
    }
    
    func hideInfo() {
        UIView.animate(withDuration: Settings.animationDuration) { [weak self] in
            self?.nameLabel.alpha = 0.0
            self?.avatarImageView.alpha = 0.0
        }
    }
}
