import MultipeerConnectivity

@available(iOS 11.0, *)
public struct P2PConnector {
	
	// MARK: - Properties
	/// The connector's and device's id
	public static var id: MCPeerID {
		InternalConnector.singleton.id
	}
	
	/// All the peers connected to this connector
	public static var connectedPeers: [MCPeerID] {
		InternalConnector.singleton.connectedPeers
	}
	
	/// The service type string that represents your service.
	/// - important: To set your service type string go to the info.plist file and add a key named "SwiftP2PConnector-Service-Type",
	/// then write your service name as a value for this key.
	public static var serviceType: String {
		InternalConnector.singleton.serviceType
	}
	
	//MARK: - Delegates
	/// Delegate responsiblie for reacting to connection status changes between this connector and another
	public static var connectionDelegate: ConnectionDelegate? {
		get {
			InternalConnector.singleton.connectionDelegate
		}
		set {
			InternalConnector.singleton.connectionDelegate = newValue
		}
	}
	
	/// Delegate responsible for handling the received data from another connector
	public static var receiveDelegate: ReceiveDelegate? {
		get {
			InternalConnector.singleton.receiveDelegate
		}
		set {
			InternalConnector.singleton.receiveDelegate = newValue
		}
	}
	
	/// Delegate responsible for presenting and dismissing the MCBrowserViewController.
	public static var peerBrowserVCDelegate: MCBrowserViewControllerDelegate? {
		get {
			InternalConnector.singleton.peerBrowserVCDelegate
		}
		set {
			InternalConnector.singleton.peerBrowserVCDelegate = newValue
		}
	}
	
	// MARK: - Methods
	/// Sends the given key to the selected peers
	/// - Parameters:
	///   - key: Key to be sent
	///   - peers: Peers to send the key
	public static func sendKey(_ key: String, to peers: [MCPeerID]) {
		InternalConnector.singleton.sendKey(key, to: peers)
	}
	
	/// Makes this connector start to host a service so other connectors can connect to it.
	/// - important: It is recommended to call this method only in the connector associated with your main application
	public static func startHosting() {
		InternalConnector.singleton.startHosting()
	}
	
	/// Makes this connector stop hosting a service, cancelling connection with every connector.
	public static func stopHosting() {
		InternalConnector.singleton.stopHosting()
	}
	
	/// Creates and returns a MCBrowserViewController to show the user available services and stablish connections between the device and the chosen service.
	///
	/// - Returns: View controller that shows in a table view every nearby service being advertised by a MCAdvertiserAssistant,
	/// if any of your P2PConnectors started hosting with the startHosting() method it will be shown in the table view.
	public static func createBrowserVC() -> MCBrowserViewController {
		InternalConnector.singleton.createBrowserVC()
	}
	
}
