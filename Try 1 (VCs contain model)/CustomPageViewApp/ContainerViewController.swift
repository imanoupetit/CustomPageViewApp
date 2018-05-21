//
//  ViewController.swift
//  CustomPageViewApp
//
//  Created by Imanou on 21/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

/**
 A view controller that binds a UIPageViewController childViewController and a UISegmentedControl
 */
class ContainerViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let array = [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.",
        "Lorem ipsum dolor sit amet."
    ]
    let pageViewController: UIPageViewController = {
        let options = [UIPageViewControllerOptionInterPageSpacingKey : 20]
        return UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }()
    let segmentedControl = SegmentedControl(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // Set the page view controller properties
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        // Set the segmented control properties
        array.enumerated().forEach { (index, _) in
            segmentedControl.insertSegment(withTitle: "\(index)", at: index, animated: true)
        }
        segmentedControl.insertSegment(withTitle: "Modal", at: segmentedControl.numberOfSegments, animated: true)
        segmentedControl.addTarget(self, action: #selector(updateDisplay), for: .valueChanged)

        // Set view hierarchy
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 60).isActive = true

        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor).isActive = true
        pageViewController.didMove(toParentViewController: self)
        
        // Set selected page and segmentedControl's selectedIndex to initial state
        segmentedControl.selectedSegmentIndex = array.indices.startIndex
        guard let initialViewController = viewController(withPageIndex: segmentedControl.selectedSegmentIndex) else { fatalError("Could not set an initial view controller") }
        pageViewController.setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: - User interaction
    
    @objc func updateDisplay(_ sender: SegmentedControl) {
        if case let validIndex = sender.selectedSegmentIndex, array.indices.contains(validIndex) {
            swipeToPage(withIndex: validIndex)
        } else {
            // index is not related to a valid pageViewController's page; let's present the modal screen
            presentModalViewController()
        }
    }
    
    // MARK: - Custom methods
    
    func swipeToPage(withIndex index: Int) {
        // index is related to a valid pageViewController's page; let's transition to this page
        guard let currentviewController = self.pageViewController.viewControllers?.last as? PurpleViewController else { return }
        
        let direction: UIPageViewControllerNavigationDirection
        switch IndexPath(index: currentviewController.pageIndex).compare(IndexPath(index: index)) {
        case .orderedAscending:     direction = .forward
        case .orderedDescending:    direction = .reverse
        default:                    return
        }

        guard let newViewController = viewController(withPageIndex: index) else { return }
        pageViewController.setViewControllers([newViewController], direction: direction, animated: true, completion: nil)
    }
    
    func presentModalViewController() {
        // We'll remove segmentedControl selection as we're in a stale state (the selected index of the segmentedControl does not match a page of the pageViewController)
        // When the modal screen is dismissed, we'll make selectedSegmentIndex match back the current presented page view controller's pageIndex
        let redViewController = RedViewController()
        redViewController.onDismiss = { [unowned self] in
            guard let currentViewController = self.pageViewController.viewControllers?.last as? PurpleViewController else { return }
            self.segmentedControl.selectedSegmentIndex = currentViewController.pageIndex
        }
        let navigationController = UINavigationController(rootViewController: redViewController)
        present(navigationController, animated: true, completion: { self.segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment })
    }
    
    func viewController(withPageIndex pageIndex: Int) -> PurpleViewController? {
        guard array.indices.contains(pageIndex) else { return nil }
        return PurpleViewController(text: array[pageIndex], pageIndex: pageIndex)
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PurpleViewController else { fatalError("Could not cast view controller to the required type") }
        return self.viewController(withPageIndex: viewController.pageIndex + 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PurpleViewController else { fatalError("Could not cast view controller to the required type") }
        return self.viewController(withPageIndex: viewController.pageIndex - 1)
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let viewController = pageViewController.viewControllers?.last as? PurpleViewController else { return }
        segmentedControl.selectedSegmentIndex = viewController.pageIndex
    }
    
}
