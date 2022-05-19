import Foundation
import MultipeerConnectivity

protocol Peer {
	var id: MCPeerID {get set}
	var mcSession: MCSession {get set}
	var advertiser: MCAdvertiserAssistant {get set}
}
