//
//  BaseViewController.swift
//  MoviesTest
//
//  Created by Camilo López on 5/17/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import UIKit
import Lottie

class BaseViewControlller: UIViewController {
    
    var loadingView = AnimationView(animation: Animation.named("lego"))
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoading()
    }
    
    func initLoading() {
        loadingView.isHidden = true
        loadingView.frame = view.bounds
        loadingView.backgroundColor = UIColor.white
        loadingView.loopMode = .loop
        loadingView.contentMode = .scaleAspectFit
        view.bringSubviewToFront(loadingView)
        view.addSubview(loadingView)
        
    }
    
    func showLoader() {
        loadingView.isHidden = false
        loadingView.play()
    }
    
    func hideLoader() {
        loadingView.isHidden = true
        loadingView.stop()
    }
}
