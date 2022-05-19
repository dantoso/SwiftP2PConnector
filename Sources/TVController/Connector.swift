import MultipeerConnectivity

@available(iOS 11.0, *)
public class Connector: NSObject, Peer, MCSessionDelegate {
	
	public lazy var id = MCPeerID(displayName: UIDevice.current.name)
	internal lazy var mcSession = MCSession(peer: id, securityIdentity: nil, encryptionPreference: .required)
	internal lazy var advertiser = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: mcSession)
		
	public var connectedPeers: [MCPeerID] {
		return mcSession.connectedPeers
	}
	
	private var serviceType: String {
			return Bundle.main.object(forInfoDictionaryKey: "mdv-hm") as! String
		}
	
	public weak var connectionDelegate: ConnectionDelegate? = nil
	public weak var receiveDelegate: ReceiveDelegate? = nil
	
	internal static let singleton = Connector()
	public static var shared: Connector { singleton }
	
	internal var receiveQueue = DispatchQueue(label: "Connector.receiveQueue")
	internal var sendQueue = DispatchQueue(label: "Connector.sendQueue")

	
	private override init() {
		super.init()
		mcSession.delegate = self
	}
	
	public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
		switch state {
			
		case .notConnected:
			connectionDelegate?.didDisconnect(with: peerID)
			
		case .connecting:
			connectionDelegate?.isConnecting(with: peerID)
			
		case .connected:
			connectionDelegate?.didConnect(with: peerID)
			
		@unknown default:
			debugPrint("Not implemented: \(peerID) is in unknown connection state")
		}
	}
	
	public func sendKey(_ key: String, to peers: [MCPeerID]) {
		sendQueue.async { [weak self] in
			let data = Data(key.utf8)
			self?.sendData(data, to: peers)
		}
	}
	
	internal func sendData(_ data: Data, to peers: [MCPeerID]) {
		guard mcSession.connectedPeers.count > 0 else {return}
		do {
			try mcSession.send(data, toPeers: peers, with: .reliable)
		}
		catch let error {
			debugPrint(error.localizedDescription)
		}
	}
	
	public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		receiveQueue.async { [weak self] in
			guard let key = String(data: data, encoding: .utf8) else {return}
			
			self?.receiveDelegate?.didReceiveKey(key)
		}
	}
	
	public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
		debugPrint("Not implemented: Did receive input stream")
	}
	
	public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
		debugPrint("Not implemented: Did start receiving resource \(resourceName)")
	}
	
	public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
		debugPrint("Not implemented: Did finish receiving resource \(resourceName)")	}
}
