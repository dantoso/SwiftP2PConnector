import Foundation
import MultipeerConnectivity

public protocol Peer {
	var id: MCPeerID {get set}
	var mcSession: MCSession {get set}
	var advertiser: MCAdvertiserAssistant {get set}
}

public protocol Sender: Peer {
	var peersToSend: [MCPeerID] {get set}
	func send(data: Data)
}

enum ConnectionError: Error {
	case failToSendData
	case failToEncodeData
}

protocol Command {
	var key: String { get set }
	func action()
	
}

extension Sender {
	func send(data: Data) throws {
		do {
			try mcSession.send(data, toPeers: peersToSend, with: .reliable)
		}
		catch {
			throw ConnectionError.failToSendData
		}
	}
}

public protocol ActionSender: Sender {
	associatedtype CommandKeyId: Hashable
	var commandKeys: [CommandKeyId: String] {get set}
}

extension ActionSender {
	func encodeKey(key: String) -> Data {
		return Data(key.utf8)
	}
}

protocol DataSender: Sender {
	associatedtype DataType
	func encodeData(_ object: DataType) -> Data
}

public protocol ConnectionDelegate: Peer, AnyObject {
	
	func didDisconnect(with peerID: MCPeerID)
	func isConnecting(with peerID: MCPeerID)
	func didConnect(with peerID: MCPeerID)
	
}

protocol ReceiveDelegate: Peer {
	func didReceiveCommand(ofKey key: String)
	
}

//struct P {
//	let p: [Command: ()->Void] = [:]
//}



