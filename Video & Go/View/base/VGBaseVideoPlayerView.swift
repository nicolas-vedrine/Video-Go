//
//  VideoPlayerView.swift
//  Video & Go
//
//  Created by Developer on 27/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VGBaseVideoPlayerView: UIView {
    
    static let assetKeysRequiredToPlay = [
        "playable",
        "hasProtectedContent"
    ]
    
    var currentTime: Double {
        get {
            return CMTimeGetSeconds(player.currentTime())
        }
        set {
            let newTime = CMTimeMakeWithSeconds(newValue, 1)
            player.seek(to: newTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        }
    }
    
    var duration: Double {
        guard let currentItem = player.currentItem else { return 0.0 }
        
        return CMTimeGetSeconds(currentItem.duration)
    }
    
    var rate: Float {
        get {
            return player.rate
        }
        
        set {
            player.rate = newValue
        }
    }
    
    var asset: AVURLAsset? {
        didSet {
            guard let newAsset = asset else { return }
            
            asynchronouslyLoadURLAsset(newAsset)
        }
    }
    
    private var playerItem: AVPlayerItem? = nil {
        didSet {
            /*
             If needed, configure player item here before associating it with a player.
             (example: adding outputs, setting text style rules, selecting media options)
             */
            player.replaceCurrentItem(with: self.playerItem)
        }
    }
    
    var playerLayer: AVPlayerLayer?
    @objc let player = AVPlayer()
    var isLoop: Bool = false
    var isAutoPlay: Bool = true
    var isPlaying: Bool = false
    
    internal var loadingBar: UISlider?
    internal var progressBar: UISlider?
    
    private static var playerViewControllerKVOContext = 0
    private var timeObserverToken: Any?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func configure(url: String) {
        if let videoURL = URL(string: url) {
            
            buildBars()
            
            addObserver(self, forKeyPath: #keyPath(player.currentItem.duration), options: [.new, .initial], context: &VGBaseVideoPlayerView.playerViewControllerKVOContext)
            addObserver(self, forKeyPath: #keyPath(player.rate), options: [.new, .initial], context: &VGBaseVideoPlayerView.playerViewControllerKVOContext)
            addObserver(self, forKeyPath: #keyPath(player.currentItem.status), options: [.new, .initial], context: &VGBaseVideoPlayerView.playerViewControllerKVOContext)
            NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
            
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            //playerLayer?.frame = UIScreen.main.bounds
            //playerLayer.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
            //print("V&G_FW___configure : ", self, playerLayer?.frame)
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            
            asset = AVURLAsset(url: videoURL)
            
            let interval = CMTimeMake(1, 1)
            timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [unowned self] time in
                let timeElapsed = Float(CMTimeGetSeconds(time))
                
                self.progressBar?.value = Float(timeElapsed)
            }
            
            
        }
    }
    
    func setAsset(url: String) -> Void {
        print("V&G_Project___setVideo : ", self, url)
        if let videoURL = URL(string: url) {
            asset = AVURLAsset(url: videoURL)
        }
    }
    
    func asynchronouslyLoadURLAsset(_ newAsset: AVURLAsset) {
        /*
         Using AVAsset now runs the risk of blocking the current thread (the
         main UI thread) whilst I/O happens to populate the properties. It's
         prudent to defer our work until the properties we need have been loaded.
         */
        newAsset.loadValuesAsynchronously(forKeys: VGBaseVideoPlayerView.assetKeysRequiredToPlay) {
            /*
             The asset invokes its completion handler on an arbitrary queue.
             To avoid multiple threads using our internal state at the same time
             we'll elect to use the main thread at all times, let's dispatch
             our handler to the main queue.
             */
            DispatchQueue.main.async {
                /*
                 `self.asset` has already changed! No point continuing because
                 another `newAsset` will come along in a moment.
                 */
                guard newAsset == self.asset else { return }
                
                /*
                 Test whether the values of each of the keys we need have been
                 successfully loaded.
                 */
                for key in VGBaseVideoPlayerView.assetKeysRequiredToPlay {
                    var error: NSError?
                    
                    if newAsset.statusOfValue(forKey: key, error: &error) == .failed {
                        let stringFormat = NSLocalizedString("error.asset_key_%@_failed.description", comment: "Can't use this AVAsset because one of it's keys failed to load")
                        
                        let message = String.localizedStringWithFormat(stringFormat, key)
                        
                        self.handleErrorWithMessage(message, error: error)
                        
                        return
                    }
                }
                
                // We can't play this asset.
                if !newAsset.isPlayable || newAsset.hasProtectedContent {
                    let message = NSLocalizedString("error.asset_not_playable.description", comment: "Can't use this AVAsset because it isn't playable or has protected content")
                    
                    self.handleErrorWithMessage(message)
                    
                    return
                }
                
                /*
                 We can play this asset. Create a new `AVPlayerItem` and make
                 it our player's current item.
                 */
                self.playerItem = AVPlayerItem(asset: newAsset)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &VGBaseVideoPlayerView.playerViewControllerKVOContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        if keyPath == #keyPath(player.currentItem.duration) {
            let newDuration: CMTime
            if let newDurationAsValue = change?[NSKeyValueChangeKey.newKey] as? NSValue {
                newDuration = newDurationAsValue.timeValue
            }
            else {
                newDuration = kCMTimeZero
            }
            let hasValidDuration = newDuration.isNumeric && newDuration.value != 0
            let newDurationSeconds = hasValidDuration ? CMTimeGetSeconds(newDuration) : 0.0
            let currentTime = hasValidDuration ? Float(CMTimeGetSeconds(player.currentTime())) : 0.0
            
            progressBar?.maximumValue = Float(newDurationSeconds)
            
            progressBar?.value = currentTime
        }
        else if keyPath == #keyPath(player.rate) {
            // Update `playPauseButton` image.
            
            let newRate = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).doubleValue
            isPlaying = newRate == 1.0 ? true : false
        }
        else if keyPath == #keyPath(player.currentItem.status) {
            // Display an error if status becomes `.Failed`.
            
            /*
             Handle `NSNull` value for `NSKeyValueChangeNewKey`, i.e. when
             `player.currentItem` is nil.
             */
            let newStatus: AVPlayerItemStatus
            
            if let newStatusAsNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber {
                newStatus = AVPlayerItemStatus(rawValue: newStatusAsNumber.intValue)!
            }
            else {
                newStatus = .unknown
            }
            
            if newStatus == .failed {
                handleErrorWithMessage(player.currentItem?.error?.localizedDescription, error:player.currentItem?.error)
            }
        }
    }
    
    func handleErrorWithMessage(_ message: String?, error: Error? = nil) {
        print("Error occured with message: \(String(describing: message)), error: \(String(describing: error),String(describing: error)).")
        
        /*let alertTitle = NSLocalizedString("alert.error.title", comment: "Alert title for errors")
        let defaultAlertMessage = NSLocalizedString("error.default.description", comment: "Default error message when no NSError provided")
        
        let alert = UIAlertController(title: alertTitle, message: message == nil ? defaultAlertMessage : message, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertActionTitle = NSLocalizedString("alert.error.actions.OK", comment: "OK on error alert")
        
        let alertAction = UIAlertAction(title: alertActionTitle, style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)*/
    }

    
    internal func buildBars() -> Void {
        buildProgressBar()
    }
    
    internal func buildProgressBar() -> Void {
        //let frame = CGRect(x: 0, y: self.bounds.size.height + 1, width: self.bounds.size.width, height: 0.2)
        let frame = CGRect(x: 0, y: self.bounds.size.height + 1, width: self.bounds.size.width, height: 0.5)
        progressBar = UISlider(frame: frame)
        progressBar?.backgroundColor = UIColor.clear
        progressBar?.minimumTrackTintColor = BLUE_COLOR
        progressBar?.maximumTrackTintColor = WHITE_COLOR
        progressBar?.thumbTintColor = UIColor.clear
        progressBar?.isUserInteractionEnabled = false
        progressBar?.value = 0
        self.addSubview(progressBar!)
    }
    
    func play() {
        if player.timeControlStatus != AVPlayerTimeControlStatus.playing {
            player.play()
        }
    }
    
    func pause() {
        player.pause()
    }
    
    func stop() {
        player.pause()
        player.seek(to: kCMTimeZero)
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        if isLoop {
            player.pause()
            player.seek(to: kCMTimeZero)
            player.play()
        }
    }
    
}
