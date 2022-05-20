import MultipeerConnectivity

@available(iOS 11.0, *)
public struct P2PConnector {
	
	public static var id: MCPeerID {
		InternalConnector.singleton.id
	}
	public static var connectedPeers: [MCPeerID] {
		InternalConnector.singleton.connectedPeers
	}
	public static var serviceType: String {
		InternalConnector.singleton.serviceType
	}
	
	public static var connectionDelegate: ConnectionDelegate? {
		get {
			InternalConnector.singleton.connectionDelegate
		}
		set {
			InternalConnector.singleton.connectionDelegate = newValue
		}
	}
	public static var receiveDelegate: ReceiveDelegate? {
		get {
			InternalConnector.singleton.receiveDelegate
		}
		set {
			InternalConnector.singleton.receiveDelegate = newValue
		}
	}
	public static var peerBrowserVCDelegate: MCBrowserViewControllerDelegate? {
		get {
			InternalConnector.singleton.peerBrowserVCDelegate
		}
		set {
			InternalConnector.singleton.peerBrowserVCDelegate = newValue
		}
	}
	
	public static func sendKey(_ key: String, to peers: [MCPeerID]) {
		InternalConnector.singleton.sendKey(key, to: peers)
	}
	
	public static func startHosting() {
		InternalConnector.singleton.startHosting()
	}
	
	public static func stopHosting() {
		InternalConnector.singleton.stopHosting()
	}
	
	public static func createBrowserVC() -> MCBrowserViewController {
		InternalConnector.singleton.createBrowserVC()
	}
	
}
