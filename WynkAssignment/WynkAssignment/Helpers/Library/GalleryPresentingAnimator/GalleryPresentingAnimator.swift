//
//  GalleryPresentingAnimator.swift
//  WynkAssignment
//
//  Created by Admin on 17/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit


class GalleryPresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let indexPath: IndexPath
    private let originFrame: CGRect
    private let duration: TimeInterval = 0.5

    init(pageIndex: Int, originFrame: CGRect) {
        self.indexPath = IndexPath(item: pageIndex, section: 0)
        self.originFrame = originFrame
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let toView = transitionContext.view(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) as? SearchImageVC,
            let fromView = fromVC.searchImageCV?.cellForItem(at: indexPath) as? SearchImageCVCell
            else {
                transitionContext.completeTransition(true)
                return
        }

        let finalFrame = toView.frame

        let viewToAnimate = UIImageView(frame: originFrame)
        viewToAnimate.image = fromView.searchImageView.image
        viewToAnimate.contentMode = .scaleAspectFill
        viewToAnimate.clipsToBounds = true
        fromView.searchImageView.isHidden = true

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(viewToAnimate)

        toView.isHidden = true

        // Determine the final image height based on final frame width and image aspect ratio
        let imageAspectRatio = viewToAnimate.image!.size.width / viewToAnimate.image!.size.height
        let finalImageheight = finalFrame.width / imageAspectRatio

        // Animate size and position
        UIView.animate(withDuration: duration, animations: {
            viewToAnimate.frame.size.width = finalFrame.width
            viewToAnimate.frame.size.height = finalImageheight
            viewToAnimate.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion:{ _ in
            toView.isHidden = false
            fromView.searchImageView.isHidden = false
            viewToAnimate.removeFromSuperview()
            transitionContext.completeTransition(true)
        })

    }
}
