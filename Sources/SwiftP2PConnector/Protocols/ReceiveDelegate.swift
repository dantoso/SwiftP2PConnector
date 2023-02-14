import Foundation
import MultipeerConnectivity

public protocol ReceiveDelegate: AnyObject {
	var commandDictionary: [String: Command] {get set}
	func didReceiveKey(_ key: String, from peerID: MCPeerID)
	func didReceiveData(_ data: Data, from peerID: MCPeerID)
	func didReceivePing(_ ping: Double, from peerID: MCPeerID)
}

public extension ReceiveDelegate {
	func didReceiveKey(_ key: String, from peerID: MCPeerID) {
		commandDictionary[key]?.action()
	}

	func didReceivePing(_ ping: Double, from peerID: MCPeerID) {}
}
