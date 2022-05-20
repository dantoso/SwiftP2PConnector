import Foundation
import MultipeerConnectivity

internal protocol Peer {
	var id: MCPeerID {get}
	var mcSession: MCSession {get set}
	var advertiser: MCAdvertiserAssistant {get set}
}
