import Foundation
import QuartzCore

extension String {

	static var pingPrefix: String {
		return "ping:"
	}

	func getPing() -> Double? {
		let prefix = String.pingPrefix
		guard self.hasPrefix(prefix) else {return nil}

		var string = self
		string.removeFirst(prefix.count)

		guard let startTime = Double(string) else {return nil}

		let ping = CACurrentMediaTime() - startTime

		return ping
	}
}
