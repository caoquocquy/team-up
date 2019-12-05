//
//  ViewController.swift
//  TeamUp
//
//  Created by Quy Cao on 12/5/19.
//  Copyright © 2019 Quy Cao. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController {
    
    struct Settings {
        static let shuffleCount = 15
        static let shuffleInterval: TimeInterval = 0.3
        static let teamLabelTextColor = UIColor(red: 0.000, green: 0.479, blue: 0.999, alpha: 1.00)
        static let teamLabelFont = UIFont.boldSystemFont(ofSize: 22)
    }
    
    var playerViews: [PlayerView] = []
    var teamLabels: [UILabel] = []
    
    private var timer: Timer?

    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var shuffleBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTitle()
        
        refreshPlayerViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stop()
    }
    
    @IBAction func shuffleAction(_ sender: Any) {
        startShufflingIfNeeded()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            startShufflingIfNeeded()
        }
    }
}

extension TeamsViewController {
    
    func updateTitle() {
        let count = DataCenter.shared.players.filter { $0.isIncluded }.count
        title = "Teams (\(count) Players)"
    }
    
    func pickPlayViews() {
        let playerViews = self.playerViews.sorted { $0.center.y < $1.center.y }.shuffled()
        
        let size = PlayerView.Settings.defaultSize,
            teamSize = 2,
            startX: CGFloat = 100.0,
            startY: CGFloat = 100.0,
            paddingX: CGFloat = 5.0,
            paddingY: CGFloat = 20.0
        
        for (index, playerView) in playerViews.enumerated() {
            let col = CGFloat(index % teamSize)
            let row = CGFloat(index / teamSize)
            
            let x = startX + col * size.width + col * paddingX
            let y = startY + row * size.width + row * paddingY
            
            if col == 0.0 {
                var frame = CGRect.zero
                frame.size = size
                let label = UILabel(frame: frame)
                label.text = "\(Int(row + 1))."
                label.alpha = 0.0
                label.textAlignment = .center
                label.textColor = Settings.teamLabelTextColor
                label.font = Settings.teamLabelFont
                label.center = CGPoint(x: 40, y: y)
                
                canvasView.addSubview(label)
                teamLabels.append(label)
            }
            
            UIView.animate(withDuration: 1.0) { [weak self] in
                playerView.center = CGPoint(x: x, y: y)
                playerView.nameLabel.alpha = 1.0
                self?.teamLabels.forEach { $0.alpha = 1.0 }
            }
        }
    }
    
    func refreshPlayerViews() {
        teamLabels.forEach { $0.removeFromSuperview() }
        teamLabels = []
        
        playerViews.forEach { $0.removeFromSuperview() }
        playerViews = DataCenter.shared.players
            .filter { $0.isIncluded }
            .map { PlayerView(player: $0) }
        playerViews.forEach { [weak self] playerView in
            self?.canvasView.addSubview(playerView)
        }
        randomPlayerViewCenters()
    }
    
    func startShufflingIfNeeded() {
        if let _ = timer { return }
        
        teamLabels.forEach { $0.removeFromSuperview() }
        teamLabels = []
        
        playerViews.forEach { $0.nameLabel.alpha = 0.0 }
        
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: Settings.shuffleInterval, repeats: true) { [weak self] _ in
            if count >= Settings.shuffleCount {
                self?.stop()
            } else {
                self?.randomPlayerViewCenters()
                count += 1
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        
        pickPlayViews()
    }
    
    func randomPlayerViewCenters() {
        playerViews.forEach { [weak self] playerView in
            guard let `self` = self else { return }
            
            UIView.animate(withDuration: Settings.shuffleInterval) {
                playerView.center = self.randomCenter()
            }
        }
    }
    
    func randomCenter() -> CGPoint {
        let padding = PlayerView.Settings.defaultSize.width / 2
        return CGPoint(
            x: CGFloat.random(in: padding...(canvasView.bounds.size.width - padding)),
            y: CGFloat.random(in: padding...(canvasView.bounds.size.height - padding))
        )
    }
}
