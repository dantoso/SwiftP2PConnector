import Foundation

extension String {
	static var keyPrefix: String {
		return "key:"
	}

	func getKey() -> String? {
		let prefix = String.keyPrefix
		guard self.hasPrefix(prefix) else {return nil}
		
		var key = self
		key.removeFirst(prefix.count)
		return key
	}
}
