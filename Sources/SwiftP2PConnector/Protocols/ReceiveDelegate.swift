import Foundation
import MultipeerConnectivity

public protocol ReceiveDelegate: AnyObject {
	var commandDictionary: [String: Command] {get set}
	func didReceiveKey(_ key: String)
	func didReceiveData(_ data: Data, from peer: MCPeerID)
}

extension ReceiveDelegate {
	func didReceiveKey(_ key: String) {
		commandDictionary[key]?.action()
	}
}
