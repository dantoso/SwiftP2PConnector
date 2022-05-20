import MultipeerConnectivity

@available(iOS 11.0, *)
final class InternalConnector: NSObject, Peer, MCSessionDelegate {
	
	internal let id = MCPeerID(displayName: UIDevice.current.name)
	internal lazy var mcSession = MCSession(peer: id, securityIdentity: nil, encryptionPreference: .required)
	internal lazy var advertiser = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: mcSession)
	
	internal var connectedPeers: [MCPeerID] {
		return mcSession.connectedPeers
	}
	
	internal var serviceType: String {
		return Bundle.main.object(forInfoDictionaryKey: "SwiftP2PConnector-Service-Type") as! String
	}
	
	internal weak var connectionDelegate: ConnectionDelegate? = nil
	internal weak var receiveDelegate: ReceiveDelegate? = nil
	internal weak var peerBrowserVCDelegate: MCBrowserViewControllerDelegate? = nil
	
	private var receiveQueue = DispatchQueue(label: "Connector.receiveQueue")
	private var sendQueue = DispatchQueue(label: "Connector.sendQueue")
	
	static let singleton = InternalConnector()
	
	private override init() {
		super.init()
		mcSession.delegate = self
	}
	
	internal func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
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
	
	internal func sendData(_ data: Data, to peers: [MCPeerID]) {
		guard mcSession.connectedPeers.count > 0 else {return}
		do {
			try mcSession.send(data, toPeers: peers, with: .reliable)
		}
		catch let error {
			debugPrint(error.localizedDescription)
		}
	}
	
	internal func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		receiveQueue.async { [weak self] in
			guard let key = String(data: data, encoding: .utf8) else {return}
			
			self?.receiveDelegate?.didReceiveKey(key)
		}
	}
	
	internal func sendKey(_ key: String, to peers: [MCPeerID]) {
		sendQueue.async { [weak self] in
			let data = Data(key.utf8)
			self?.sendData(data, to: peers)
		}
	}
	
	internal func startHosting() {
		advertiser.start()
		debugPrint("\(id): Started hosting")
	}
	
	internal func stopHosting() {
		advertiser.stop()
		debugPrint("\(id): Stopped hosting")
	}
	
	internal func createBrowserVC() -> MCBrowserViewController {
		let mcBrowser = MCBrowserViewController(serviceType: serviceType, session: mcSession)
		mcBrowser.delegate = peerBrowserVCDelegate
		
		return mcBrowser
	}
	
	internal func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
		debugPrint("Not implemented: Did receive input stream")
	}
	
	internal func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
		debugPrint("Not implemented: Did start receiving resource \(resourceName)")
	}
	
	internal func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
		debugPrint("Not implemented: Did finish receiving resource \(resourceName)")	}
}

