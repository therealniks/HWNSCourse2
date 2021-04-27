//
//  ScaleImage.swift
//  Course2
//
//  Created by N!kS on 29.12.2020.
//
import UIKit

protocol ScaleImageDelegate: AnyObject {
    func needToSwipe(fromIndexPath: Int, fullscreen: UIImageView, usedIndexPath: Int)
}

class ScaleImage: UIImageView {
    
    weak var delegate: ScaleImageDelegate?
    var indexPathToUse: Int?
    var usedIndexPath: Int?
    var fullscreenImageView: UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
     func setup() {
        self.isUserInteractionEnabled = true
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(showFullscreen))
        self.addGestureRecognizer(touchGesture)
    }
    
     func createFullscreenPhoto() -> UIImageView {

        let tmpImageView = UIImageView(frame: self.frame)
        tmpImageView.image = self.image
        tmpImageView.contentMode = UIView.ContentMode.scaleAspectFit
        tmpImageView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        tmpImageView.alpha = 0.0
        tmpImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideFullscreen))
        tmpImageView.addGestureRecognizer(tap)
        return tmpImageView
    }
    
    @objc func showFullscreen() {
        
        let window = UIApplication.shared.windows.first!
            self.fullscreenImageView = createFullscreenPhoto()
            guard let nonEmptyFullScreenImageView = fullscreenImageView else { return }
            window.addSubview(nonEmptyFullScreenImageView)
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: {
                            nonEmptyFullScreenImageView.frame = window.frame
                            nonEmptyFullScreenImageView.alpha = 1
                            nonEmptyFullScreenImageView.layoutSubviews()
                })
        
    }
    
    @objc func hideFullscreen() {
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.fullscreenImageView?.frame = self.frame
                        self.fullscreenImageView?.alpha = 0
        }, completion: { finished in
                        self.fullscreenImageView?.removeFromSuperview()
                        self.fullscreenImageView = nil
        })
    }
}
