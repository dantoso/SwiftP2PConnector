import Foundation
import MultipeerConnectivity

public protocol ReceiveDelegate: AnyObject {
	var commandDictionary: [String: Command] {get set}
	func didReceiveKey(_ key: String)
}

extension ReceiveDelegate {
	func didReceiveKey(_ key: String) {
		commandDictionary[key]?.action()
	}
}
