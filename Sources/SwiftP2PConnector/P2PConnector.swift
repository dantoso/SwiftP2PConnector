import MultipeerConnectivity

@available(iOS 11.0, *)
public struct P2PConnector {
	
	static var id: MCPeerID {
		InternalConnector.singleton.id
	}
	static var connectedPeers: [MCPeerID] {
		InternalConnector.singleton.connectedPeers
	}
	static var serviceType: String {
		InternalConnector.singleton.serviceType
	}
	
	static var connectionDelegate: ConnectionDelegate? {
		get {
			InternalConnector.singleton.connectionDelegate
		}
		set {
			InternalConnector.singleton.connectionDelegate = newValue
		}
	}
	static var receiveDelegate: ReceiveDelegate? {
		get {
			InternalConnector.singleton.receiveDelegate
		}
		set {
			InternalConnector.singleton.receiveDelegate = newValue
		}
	}
	static var peerBrowserVCDelegate: MCBrowserViewControllerDelegate? {
		get {
			InternalConnector.singleton.peerBrowserVCDelegate
		}
		set {
			InternalConnector.singleton.peerBrowserVCDelegate = newValue
		}
	}
	
	static func sendKey(_ key: String, to peers: [MCPeerID]) {
		InternalConnector.singleton.sendKey(key, to: peers)
	}
	
	static func startHosting() {
		InternalConnector.singleton.startHosting()
	}
	
	static func stopHosting() {
		InternalConnector.singleton.stopHosting()
	}
	
	static func createBrowserVC() -> MCBrowserViewController {
		InternalConnector.singleton.createBrowserVC()
	}
	
}
