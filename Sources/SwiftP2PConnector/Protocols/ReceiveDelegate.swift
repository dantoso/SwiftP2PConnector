import Foundation
import MultipeerConnectivity

public protocol ReceiveDelegate: AnyObject {
	var commandDictionary: [String: Command] {get set}
	func didReceiveKey(_ key: String, from peerID: MCPeerID)
	func didReceiveData(_ data: Data, from peerID: MCPeerID)
}

extension ReceiveDelegate {
	func didReceiveKey(_ key: String, from peerID: MCPeerID) {
		commandDictionary[key]?.action()
	}
}
