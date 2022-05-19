import MultipeerConnectivity

@available(iOS 11.0, *)
public class ControllerConnector: NSObject, Peer, MCSessionDelegate {
	
	public lazy var id = MCPeerID(displayName: UIDevice.current.name)
	public lazy var mcSession = MCSession(peer: id, securityIdentity: nil, encryptionPreference: .required)
	public lazy var advertiser = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: mcSession)
	public var serviceType: String {
		didSet {
			advertiser = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: mcSession)
		}
	}
		
	var connectedPeers: [MCPeerID] {
		return mcSession.connectedPeers
	}
	
	public weak var connectionDelegate: ConnectionDelegate? = nil
		
	init(serviceType: String) {
		self.serviceType = serviceType
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
	
	public func sendData(_ data: Data, to peers: [MCPeerID]) {
		do {
			try mcSession.send(data, toPeers: peers, with: .reliable)
		}
		catch let error {
			debugPrint(error.localizedDescription)
		}
	}
	
	
	public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		debugPrint("Not implemented: Did receive data")
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



