import Foundation
import UIKit

public protocol NibLoadable {
    static var name: String { get }
    static var bundle: NSBundle? { get }
}

public extension NibLoadable {
    static var name: String {
        return String(Self)
    }

    static var bundle: NSBundle? {
        return nil
    }

    static var nib: UINib {
        return UINib(nibName: self.name, bundle: self.bundle)
    }

    static func loadFirst(owner owner: AnyObject? = nil, options: [NSObject: AnyObject]? = nil) -> Self {
        guard let fromNib = nib.instantiateWithOwner(owner, options: options).first else {
            fatalError("The .nib named \(name) is empty")
        }
        guard let typedObject = fromNib as? Self else {
            fatalError("Expected first object of .nib named \(name) to be of type \(self) but actual type is \(fromNib.self)")
        }
        return typedObject
    }
}
