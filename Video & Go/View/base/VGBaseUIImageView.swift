    //
    //  UIImageViewAsync.swift
    //  TestVimeoChannel
    //
    //  Created by Developer on 08/10/2018.
    //  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
    //
    
    import UIKit
    
    class UIImageViewAsync: UIImageView, URLSessionDownloadDelegate {
        
        internal var progressBar: UIProgressView!
        internal var _loadingStyle: LoadingStyle = LoadingStyle.ACTIVITY_INDICATOR
        internal var _loadingView: UIView!
        
        var onLoadComplete: (() -> ())?
        
        /*
         // Only override draw() if you perform custom drawing.
         // An empty implementation adversely affects performance during animation.
         override func draw(_ rect: CGRect) {
         // Drawing code
         }
         */
        
        func downloadImage(urlString: String, loadingStyle: LoadingStyle = LoadingStyle.ACTIVITY_INDICATOR) {
            if let url = URL(string: urlString) {
                print("V&G_FW___downloadImage : ", self, url)
                
                _loadingStyle = loadingStyle
                buildLoading()
                
                let configuration = URLSessionConfiguration.default
                let operationQueue = OperationQueue()
                let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
                guard let url = URL(string: urlString) else { return }
                let downloadTask = urlSession.downloadTask(with: url)
                downloadTask.resume()
            }
        }
        
        internal func buildLoading() {
            if _loadingView == nil {
                switch _loadingStyle {
                case LoadingStyle.ACTIVITY_INDICATOR:
                    buildActivityIndicator()
                case LoadingStyle.NONE:
                    print("V&G_FW___buildLoading : ", self, LoadingStyle.NONE)
                }
            }
        }
        
        internal func buildActivityIndicator() {
            _loadingView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            self.addSubview(_loadingView)
            
            /*_loadingView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
             _loadingView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true*/
            _loadingView.center = self.center
            
            let activityIndic: UIActivityIndicatorView = _loadingView as! UIActivityIndicatorView
            activityIndic.startAnimating()
        }
        
        internal func buildProgressBar() {
            progressBar = UIProgressView()
            //let rect: CGRect = self.bounds
            //progressBar.frame = CGRect(x: self.bounds.maxX, y: self.bounds.maxY, width: 100, height: 100)
            progressBar.center = self.center
            self.addSubview(progressBar)
        }
        
        
    }
    
    extension UIImageViewAsync {
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            let percentage: Float = Float(totalBytesWritten / totalBytesExpectedToWrite)
            
            DispatchQueue.main.async {
                //self.percentageLabel.text = "\(Int(percentage * 100))%"
                switch self._loadingStyle {
                case LoadingStyle.ACTIVITY_INDICATOR:
                    print("V&G_FW___urlSession : ", self, LoadingStyle.ACTIVITY_INDICATOR)
                case LoadingStyle.NONE:
                    print("V&G_FW___urlSession : ", self, LoadingStyle.NONE)
                }
            }
            
            print(percentage)
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            print("V&G_FW___Finished downloading file : ", self)
            let data = try! Data(contentsOf: location)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.alpha = 0
                self.image = image
                UIView.animate(withDuration: 0.5, animations: {
                    self.alpha = 1.0
                }) { (finished) in
                    
                }
                if self._loadingView != nil {
                    self._loadingView.removeFromSuperview()
                    self._loadingView = nil
                }
                //                if self.progressBar != nil {
                //                    self.progressBar.removeFromSuperview()
                //                    self.progressBar = nil
                //                }
                self.onLoadComplete!()
            }
        }
        
    }
