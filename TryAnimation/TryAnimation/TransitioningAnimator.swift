//
//  TransitioningAnimator.swift
//  TryAnimation
//
//  Created by Egor Gryadunov on 14.07.2022.
//

import UIKit

final class TransitioningAnimator: NSObject {
    // MARK: - Private properties
    private var type: PresentationType
    private var sourceViewController: ViewController
    private var destinationViewController: ImageViewController

//    private var imageViewSnapshot: UIView
//    private let imageViewRect: CGRect

    init?(
        type: PresentationType,
        sourceViewController: ViewController,
        destinationViewController: ImageViewController
//        ,
//        imageViewSnapshot: UIView
    ) {
        self.type = type
        self.sourceViewController = sourceViewController
        self.destinationViewController = destinationViewController
//        self.imageViewSnapshot = imageViewSnapshot

//        guard let window = sourceViewController.view.window ?? destinationViewController.view.window
//        else { return nil }
//        self.imageViewRect = sourceViewController.imageview.convert(sourceViewController.imageview.bounds, to: window)
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension TransitioningAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let destinationView = destinationViewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        destinationView.alpha = 0
        containerView.addSubview(destinationView)
        if type == .present {
            sourceViewController.titleLabel.isHidden = true
        }
        

        guard let window = sourceViewController.view.window ?? destinationViewController.view.window
                ,
//              let sourceImageSnapshot = sourceViewController.getImageSnapshot(),
              let destinationImageSnapshot = destinationViewController.getImageSnapshot(),
              let placeholderSnapshot = sourceViewController.placeholderView.snapshotView(afterScreenUpdates: true),
              let leftButtonSnapshot = destinationViewController.button1.snapshotView(afterScreenUpdates: true),
              let rightButtonSnapshot = destinationViewController.button2.snapshotView(afterScreenUpdates: true),
              let titleLabelSnapshot = destinationViewController.titleLabel.snapshotView(afterScreenUpdates: true),
              let sideMenuSnapshot = sourceViewController.sideMenu.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }

        let leftButtonRect = destinationViewController.button1.convert(
            destinationViewController.button1.bounds,
            to: window
        )
        let rightButtonRect = destinationViewController.button2.convert(
            destinationViewController.button2.bounds,
            to: window
        )
        leftButtonSnapshot.frame = leftButtonRect
        rightButtonSnapshot.frame = rightButtonRect

        let isPresenting = type.isPresenting
        if isPresenting {
//            imageViewSnapshot = sourceImageSnapshot // TODO: Try to rmove it
        } else {
            
        }

        [
            destinationImageSnapshot, placeholderSnapshot,
            leftButtonSnapshot, rightButtonSnapshot, titleLabelSnapshot,
            sideMenuSnapshot
        ].forEach { containerView.addSubview($0) }

        let startImageFrame = isPresenting
            ? sourceViewController.imageview.convert(sourceViewController.imageview.bounds, to: window)
            : destinationViewController.imageview.convert(destinationViewController.imageview.bounds, to: window)
        let finishImageFrame = isPresenting
            ? destinationViewController.imageview.convert(destinationViewController.imageview.bounds, to: window)
            : CGRect(
                x: startImageFrame.origin.x + 50,
                y: startImageFrame.origin.y - 50,
                width: startImageFrame.width / 1.25,
                height: startImageFrame.height - 100 //* (2/3) + 55
            )

        var placeholderRect = sourceViewController.placeholderView.convert(
            sourceViewController.placeholderView.bounds,
            to: window
        )
        placeholderRect = CGRect(
            x: placeholderRect.origin.x,
            y: destinationView.frame.height *  (2/3),
            width: placeholderRect.width,
            height: placeholderRect.height
        )
        placeholderSnapshot.frame = placeholderRect
        let placeholderDismissRect = CGRect(
            x: placeholderRect.origin.x,
            y: placeholderRect.origin.y,
            width: placeholderRect.width,
            height: destinationView.bounds.height * 0.75)
        placeholderRect = CGRect(
            x: placeholderRect.origin.x,
            y: placeholderRect.origin.y + destinationView.frame.height / 3,
            width: placeholderRect.width,
            height: placeholderRect.height
        )
        var distinationTitleLabelRect = destinationViewController.titleLabel.convert(
            destinationViewController.titleLabel.bounds,
            to: window
        )
        let sourceTitleLabelRect = sourceViewController.titleLabel.convert(
            sourceViewController.titleLabel.bounds,
            to: window
        )
        titleLabelSnapshot.frame = sourceTitleLabelRect
        let titleDisFrame = sourceTitleLabelRect
        var sideMenuRect = sourceViewController.sideMenu.convert(
            sourceViewController.sideMenu.bounds,
            to: window
        )
        sideMenuRect = CGRect(
            x: (destinationView.bounds.width - 40 - 20),
            y: (destinationView.bounds.height - 120) / 2,
            width: 40,
            height: 120
        )
        sideMenuSnapshot.frame = sideMenuRect
        let sideMenuDissmesRect = sideMenuRect
        sideMenuRect = CGRect(
            x: sideMenuRect.origin.x + 60,
            y: sideMenuRect.origin.y,
            width: sideMenuRect.width,
            height: sideMenuRect.height
        )
        
        if !isPresenting {
            titleLabelSnapshot.isHidden = true
        }

        destinationImageSnapshot.frame = startImageFrame
        
        if !isPresenting {
            placeholderSnapshot.frame = placeholderRect
            titleLabelSnapshot.frame = distinationTitleLabelRect
            sideMenuSnapshot.frame = sideMenuRect
            placeholderRect = placeholderDismissRect
            distinationTitleLabelRect = titleDisFrame
            sideMenuRect = sideMenuDissmesRect
        }

        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0,
            options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
//                    self.imageViewSnapshot.frame = isPresenting ? distinationImageViewRect : self.imageViewRect
                    destinationImageSnapshot.frame = finishImageFrame
                    placeholderSnapshot.frame = placeholderRect
                    titleLabelSnapshot.frame = distinationTitleLabelRect
                    sideMenuSnapshot.frame = sideMenuRect
                }
            },
            completion: { _ in
                self.sourceViewController.titleLabel.isHidden = false
//                self.imageViewSnapshot.removeFromSuperview()
                destinationImageSnapshot.removeFromSuperview()
                leftButtonSnapshot.removeFromSuperview()
                rightButtonSnapshot.removeFromSuperview()
                placeholderSnapshot.removeFromSuperview()
                titleLabelSnapshot.removeFromSuperview()
                sideMenuSnapshot.removeFromSuperview()
                destinationView.alpha = 1
                transitionContext.completeTransition(true)
            })
    }
}

// MARK: - Supporting
extension TransitioningAnimator {
    enum PresentationType {
        case present
        case dismiss

        var isPresenting: Bool { self == .present }
    }
}
