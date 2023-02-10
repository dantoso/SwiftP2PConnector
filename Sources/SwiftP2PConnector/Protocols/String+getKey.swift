import Foundation

extension String {
	static var keyPrefix: String {
		return "key:"
	}

	func getKey() -> String? {
		guard self.hasPrefix(String.keyPrefix) else {return nil}
		
		var key = self
		key.removeFirst(4)
		return key
	}
}
