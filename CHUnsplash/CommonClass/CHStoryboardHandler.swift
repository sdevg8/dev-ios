//
//  CHStoryboardHandler.swift
//  CHUnsplash
//
//  Created by user on 07/04/21.
//

import UIKit

protocol StoryboardIdentifiable: class {
    static var storyboardIdentifier: String { get }
}

enum Storyboard: String {
    case main
    
    public var name: String {
        switch self {
        case .main:
            return "Main"
        }
    }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func load(storyboardName: String, bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let vc = storyboard.instantiateViewController(identifier: storyboardIdentifier)as? Self else {
            fatalError("Couldn't instantiate view controller with identifier with \(storyboardIdentifier)")
        }
        return vc
    }
    static func load(from: Storyboard) -> Self{
        return load(storyboardName: from.name)
    }
}
extension UIViewController: StoryboardIdentifiable {}
