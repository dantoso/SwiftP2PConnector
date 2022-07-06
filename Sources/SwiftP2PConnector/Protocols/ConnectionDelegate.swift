import Foundation
import MultipeerConnectivity

public protocol ConnectionDelegate: AnyObject {
	func didDisconnect(with peerID: MCPeerID)
	func isConnecting(with peerID: MCPeerID)
	func didConnect(with peerID: MCPeerID)
	
}
