//
//  UIPreviewInteraction.swift
//  ios10Test
//
//  Created by ジェローム　チャ on 2018/07/24.
//  Copyright © 2018 ジェローム　チャ. All rights reserved.
//

import UIKit

class Preview3DTouchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    var previewInteraction: UIPreviewInteraction?
    let previousValue: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        previewInteraction = UIPreviewInteraction(view: view)
        previewInteraction?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.isHidden = false
        blurEffectView.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageView.isHidden = true
        blurEffectView.isHidden = true
    }
}

extension Preview3DTouchViewController: UIPreviewInteractionDelegate {
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
        blurEffectView.alpha = 1 - transitionProgress
        if ended {
            blurEffectView.alpha = 0
        }
    }

    func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {
        blurEffectView.alpha = 1
    }

    // optional
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdateCommitTransition transitionProgress: CGFloat, ended: Bool) {
        if ended {
            blurEffectView.alpha = 1
        }
    }
}
