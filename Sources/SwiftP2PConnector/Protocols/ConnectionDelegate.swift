import Foundation
import MultipeerConnectivity

public protocol ConnectionDelegate: AnyObject {
	func didDisconnect(to peerID: MCPeerID)
	func isConnecting(to peerID: MCPeerID)
	func didConnect(to peerID: MCPeerID)
}
