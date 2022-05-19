import Foundation
import MultipeerConnectivity

public protocol ConnectionDelegate: AnyObject {
	
	func didDisconnect(with peerID: MCPeerID)
	func isConnecting(with peerID: MCPeerID)
	func didConnect(with peerID: MCPeerID)
	
}

public protocol ReceiveDelegate: AnyObject {
		
	var commandDictionary: [String: Command] {get set}
	func didReceiveKey(_ key: String)
	
}

extension ReceiveDelegate {
	func didReceiveKey(_ key: String) {
		commandDictionary[key]?.action()
	}
}
