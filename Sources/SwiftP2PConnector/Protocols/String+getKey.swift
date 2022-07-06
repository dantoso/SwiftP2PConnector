import Foundation

extension String {
	func getKey() -> String? {
		guard self.hasPrefix("key:") else {return nil}
		
		var key = self
		key.removeFirst(4)
		return key
	}
}
