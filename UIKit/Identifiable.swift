//
//  Identifiable.swift
//  StandardAdditions
//
//  Created by James Froggatt on 11.06.2016.
//  Copyright © 2016 James Froggatt. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public protocol InstantiableVC {
	static func instantiate() -> Self
}

///Conforming ViewControllers provide their storyboard ID as a static property for easy instantiation.
public protocol StoryboardIdentifiable: InstantiableVC {
	///Returns this type's unique storyboard ID.
	static var storyboardID: String {get}
}
public extension StoryboardIdentifiable where Self: UIViewController {
	static var storyboardID: String {return String(describing: self)}
	
	static func instantiate() -> Self {
		return UIStoryboard(name: "Main", bundle: .main).instantiateViewController()
	}
}

public extension UIStoryboard {
	///Initializer takes a String convertible type, for use with enums modelling an app's storyboards.
	convenience init<StringRepresentable>(storyboard: StringRepresentable, bundle: Bundle? = nil) where
			StringRepresentable: RawRepresentable, StringRepresentable.RawValue == String {
		self.init(name: storyboard.rawValue, bundle: bundle)
	}
	
	///Instantiates a storyboard based on its storyboardID.
	func instantiateViewController<Identifiable>(_: Identifiable.Type) -> Identifiable! where
			Identifiable: UIViewController, Identifiable: StoryboardIdentifiable {
		return instantiateViewController()
	}
	
	///Instantiates a storyboard based on its storyboardID.
	func instantiateViewController<Identifiable>() -> Identifiable! where
			Identifiable: UIViewController, Identifiable: StoryboardIdentifiable {
		return self.instantiateViewController(withIdentifier: Identifiable.storyboardID) as? Identifiable
	}
	///Instantiates a storyboard based on its storyboardID.
	func instantiateViewController<StringRepresentable>(withIdentifier identifier: StringRepresentable) -> UIViewController! where
			StringRepresentable: RawRepresentable, StringRepresentable.RawValue == String {
		return self.instantiateViewController(withIdentifier: identifier.rawValue)
	}
}
#endif
