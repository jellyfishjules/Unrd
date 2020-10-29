//
//  StoryViewController.swift
//  UnrdiOS
//
//  Created by Julian Ramkissoon on 29/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import UIKit
import Unrd

public final class StoryViewController: UIViewController {
    
    private var loader: StoryLoading?
    
    public convenience init(loader: StoryLoading) {
        self.init()
        self.loader = loader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loader?.load(completion: { (_) in
            
        })
    }
}
