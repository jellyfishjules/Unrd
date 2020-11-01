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


