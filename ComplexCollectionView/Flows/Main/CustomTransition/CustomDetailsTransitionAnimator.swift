//
//  CustomDetailsTransitionAnimator.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 26.02.2023.
//

import UIKit

class CustomDetailsTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect.zero
    
    private let duration: TimeInterval = 1.0
    
    // MARK: Internal
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let destinationView = transitionContext.view(forKey: .to)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        let initialFrame = originFrame
        let finalFrame = destinationView.frame
        
        let xScaleFactor = initialFrame.width / finalFrame.width
        let yScaleFactor = initialFrame.height / finalFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        destinationView.transform = scaleTransform
        destinationView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY
        )
        destinationView.clipsToBounds = true
        destinationView.layer.masksToBounds = true
        
        containerView.addSubview(destinationView)
        containerView.bringSubviewToFront(destinationView)
        
        UIView.animate(
          withDuration: duration,
          delay: 0.0,
          usingSpringWithDamping: 0.7,
          initialSpringVelocity: 0.2,
          animations: {
              destinationView.transform = .identity
              destinationView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
          }, completion: { _ in
              transitionContext.completeTransition(true)
          }
        )
    }
}
