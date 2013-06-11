package gamekitP2P.data
{
	import com.jamieowen.ane.ios.p2p.GKPeerConnectionState;
	import com.jamieowen.ane.ios.p2p.GKSessionEvent;
	import com.jamieowen.ane.ios.p2p.GKSendDataMode;
	import gamekitP2P.events.P2PDataEvent;
	import com.jamieowen.ane.ios.p2p.GKPeerPickerControllerEvent;
	import com.jamieowen.ane.ios.p2p.GKPeerPickerController;
	import com.jamieowen.ane.ios.p2p.GKPeerToPeer;
	import flash.events.EventDispatcher;

	/**
	 * @author jamieowen
	 */
	public class P2PData extends EventDispatcher
	{
		public static const CONNECTION_TYPE_UNDEFINED:String = "undefinedConnectionType";
		public static const CONNECTION_TYPE_HOST:String = "hostConnectionType";
		public static const CONNECTION_TYPE_CLIENT:String = "clientConnectionType";
		public static const CONNECTION_TYPE_PEERPICKER:String = "peerPickerConnectionType";
		
		public var connectionType:String = CONNECTION_TYPE_UNDEFINED;
		public var connected:Boolean = false;
		public var peerList:Vector.<String>;
		
		public var keysInited:Boolean = false;
		private var _syncDataKeys:Object;
		
		private var _gkPeerToPeer:GKPeerToPeer;	
		private var _peerPicker:GKPeerPickerController;
		
		private function get gkPeerToPeer():GKPeerToPeer
		{
			if( !_gkPeerToPeer )
			{
				_gkPeerToPeer = new GKPeerToPeer();	
			}
			
			return _gkPeerToPeer;
		}
		
		public function addKeyValue( key:String, defaultValue:* ):void
		{
			if( _syncDataKeys == null ){
				_syncDataKeys = {};
			}
			_syncDataKeys[key] = defaultValue;
		}
		
		public function setKeyValue( key:String, value:* ):void
		{
			if( _syncDataKeys )
			{
				_syncDataKeys[key] = value;
				
				// update values.
				sync();
			}
		}
		
		public function getKeyValue(key:String):*
		{
			if( _syncDataKeys )
				return _syncDataKeys[key];
			else
				return null;
		}
		
		public function getDisplayName():String
		{
			if( connected )
				return this.gkPeerToPeer.session.displayName;
			else
				return "cannot get display name.";
		}
		
		public function getSessionID():String
		{
			if( connected )
				return this.gkPeerToPeer.session.sessionID;
			else	
				return "cannot get session id";
		}
		
		public function getSessionMode():String
		{
			if( connected )
				return this.gkPeerToPeer.session.sessionMode.toString();
			else
				return "unable to get session mode.";
		}
		
		public function getPeerID():String
		{
			if( connected )
				return this.gkPeerToPeer.session.peerID;
			else
				return "cannot get peerID";
		}
		
		private function toJSON():String
		{
			return JSON.stringify(_syncDataKeys);
		}
		
		private function fromJSON(json:String):void
		{
			_syncDataKeys = JSON.parse(json);
		}
		
		public function getConnectedPeersByID():Vector.<String>
		{
			if( connected ){
				return gkPeerToPeer.session.peersWithConnectionState(GKPeerConnectionState.CONNECTED);
			}else{
				var result:Vector.<String> = new Vector.<String>();
				result.push( "Unable to get peers ids..");
				result.push( "Unable to get peers ids..");
				return result;
			}
		}
		
		public function getConnectedPeersByName():Vector.<String>
		{
			if( connected ){
				const peerIDs:Vector.<String> = gkPeerToPeer.session.peersWithConnectionState(GKPeerConnectionState.CONNECTED);
				
				const names:Vector.<String> = new Vector.<String>();
				
				for( var i:int = 0; i<peerIDs.length; i++ )
				{
					names.push( gkPeerToPeer.session.displayNameForPeer(peerIDs[i]));
				}
				
				return names;
			}else{
				var result:Vector.<String> = new Vector.<String>();
				result.push( "Unable to get peer names.." );
				result.push( "Unable to get peer names.." );
				return result;
			}
		}
		
		public function P2PData()
		{
			super();
		}
		
		public function createPeerPicker():void
		{
			_peerPicker = gkPeerToPeer.createGKPeerPickerController();
			
			if( _peerPicker )
			{
				_peerPicker.addEventListener( GKPeerPickerControllerEvent.CONTROLLER_DID_CANCEL, onPeerPickerEvent );
				_peerPicker.addEventListener( GKPeerPickerControllerEvent.DID_CONNECT_PEER, onPeerPickerEvent );
				
				_peerPicker.show();
			}
		}
		
		private function setConnected(status:Boolean):void
		{
			if( connected == status )
				return;
				
			
			if( status )
			{
				connected = true;
				gkPeerToPeer.session.addEventListener( GKSessionEvent.DATA_RECEIVED, onDataReceived );
				
			}else
			if( connected )
			{
				connected = false;
				gkPeerToPeer.session.disconnectFromAllPeers();
				gkPeerToPeer.session.dispose();
			}
		}
		
		private function sync():void
		{
			// update data
			if( connected )
			{	
				// perform different action depending on connection type.
				switch( connectionType )
				{
					case CONNECTION_TYPE_PEERPICKER :
						gkPeerToPeer.session.sendDataToAllPeers( toJSON(), GKSendDataMode.RELIABLE );
						
						break;
					case CONNECTION_TYPE_HOST :
						// send data to all peers
						break;
					case CONNECTION_TYPE_CLIENT :
						// send data to the host and the host will send data
						break;
				}
			}			
		}
		
		private function onPeerPickerEvent( ev:GKPeerPickerControllerEvent ):void
		{
			switch( ev.type )
			{
				case GKPeerPickerControllerEvent.CONTROLLER_DID_CANCEL :
					_peerPicker.dismiss();
					_peerPicker.dispose();
					
					dispatchEvent( new P2PDataEvent(P2PDataEvent.PEER_PICKER_CANCELLED));
					break;
					
				case GKPeerPickerControllerEvent.DID_CONNECT_PEER :
					_peerPicker.dismiss();
					_peerPicker.dispose();
					
					setConnected(true);
					
					dispatchEvent( new P2PDataEvent(P2PDataEvent.SESSION_CREATED));
					break;
			}
		}		
		
		private function onDataReceived( event:GKSessionEvent ):void
		{
			// only trigger if data was not sent by this peer
			if( event.peerID != gkPeerToPeer.session.peerID )
			{
				fromJSON( event.data );
				
				dispatchEvent( new P2PDataEvent(P2PDataEvent.DATA_RECEIVED));
			}
		}
	}
}
