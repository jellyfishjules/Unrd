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
    
    var viewModel: StoryViewModel?

    @IBOutlet weak private(set) public var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak private(set) public var shortSummaryLabel: UILabel!
    @IBOutlet weak private(set) public var nameLabel: UILabel!
    @IBOutlet weak private(set) public var videoViewContainer: PlayerView!
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel?.viewDidLoad()
    }
    
    private func setupBindings() {
        viewModel?.onLoadingStateChange = { [weak self] loading in
            if loading {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }
        }
        
        // We can also user seperate controllers to manage the view models once we think the main VC is doing too much. For example if we decide to add some images, we can add an image controller, with its own view model and dependencies, which we can compose in the composition root. This will keep things very lightweight inside our main VC and other components.
        
        
        viewModel?.onStoryLoad = { [weak self] result in
            self?.nameLabel.isHidden = false
            self?.shortSummaryLabel.isHidden = false
            self?.nameLabel.text = result.name
            self?.shortSummaryLabel.text = result.shortSumary
            guard let heroVideoURL = result.heroVideo?.resourceUri else {
                return
            }
            self?.loadHeroVideo(from: heroVideoURL)
        }
    }
    
    private func loadHeroVideo(from url: URL) {
        videoViewContainer.configure(with: url)
    }
}


