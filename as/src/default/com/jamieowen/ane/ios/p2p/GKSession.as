package com.jamieowen.ane.ios.p2p {
	import flash.events.EventDispatcher;
	
	
	[Event(name="gkSessionChangeState", type="com.jamieowen.ane.ios.p2p.GKSessionEvent")]
	
	[Event(name="gkSessionDidReceiveConnectionRequestFromPeer", type="com.jamieowen.ane.ios.p2p.GKSessionEvent")]
	
	[Event(name="gkSessionDataReceived", type="com.jamieowen.ane.ios.p2p.GKSessionEvent")]
	
	/**
	* Stub class for GKSession
	*
	* @author jamieowen
	*/
	public class GKSession extends EventDispatcher
	{
		//--//////////////////////////////////////////////////
		//--//// GETTERS/SETTERS
		
		
		//--//////////////////////////////////////////////////
		//--//// SEARCHING FOR OTHER PEERS
			
		public function get available():Boolean
		{
			// stub
			return false;
		}
		
		public function set available($available:Boolean):void
		{
			// stub
		}
		
		//--//////////////////////////////////////////////////
		//--//// INFORMATION ABOUT THE SESSION (read only)
		
 		public function get displayName():String
		{
			// stub
			return "";
		}
  		
		public function get peerID():String
		{
			// stub
			return "";
		}
		
  		public function get sessionID():String
		{
			// stub
			return "";
		}
		
		public function get sessionMode():String
		{
			// stub
			return "";
		}
		
		//--//////////////////////////////////////////////////
		//--//// WORKING WITH CONNECTED PEERS
		
		public function get disconnectTimeout():Number
		{
			// stub
			return 0;
		}
		

		public function set disconnectTimeout( $timeout:Number ):void
		{
			// stub

		}
				
		
  
		/**
		* Class Constructor Description
		*/
		public function GKSession( $p2p:GKPeerToPeer )
		{
			
		}
		
		//--//////////////////////////////////////////////////
		//--//// METHODS
		
		
		//--//////////////////////////////////////////////////
		//--//// CREATING A SESSION
		
		public function initWithSessionID( $id:String, $displayName:String, $sessionMode:uint = GKSessionMode.PEER ):void
		{
			// stub
		}
		
		//--//////////////////////////////////////////////////
		//--//// OBTAINING INFORMATION ABOUT PEERS
		
		public function peersWithConnectionState( $state:uint = GKPeerConnectionState.AVAILABLE ):Vector.<String>
		{
			// stub
			return null;
		}
		
		
		public function displayNameForPeer($peerID:String):String
		{
			// stub
			return "";
		}
		
		//--//////////////////////////////////////////////////
		//--//// CONNECTING TO A REMOTE PEER
		
		public function connectToPeer($peerID:String, $timeout:Number):void
		{
			// stub
		}
		
		public function cancelConnectToPeer($peerID:String):void
		{
			// stub
		}
		
		//--//////////////////////////////////////////////////
		//--//// RECEIVING CONNECTIONS FROM REMOTE PEER
		
		public function acceptConnectionFromPeer( $peerID:String ):Boolean
		{
			// stub
			return false;
		}
		

		public function denyConnectionFromPeer( $peerID:String ):void
		{
			// stub
		}
		
		//--//////////////////////////////////////////////////
		//--//// WORKING WITH CONNECTED PEERS
		
		public function sendData( $data:String, $peers:Vector.<String>, $dataMode:uint = GKSendDataMode.RELIABLE ):Boolean
		{
			// stub
			return false;
		}
		
		public function sendDataToAllPeers( $data:String, $dataMode:uint = GKSendDataMode.RELIABLE ):Boolean
		{
			// stub
			return false;
		}
		
		
		public function disconnectFromAllPeers():void
		{
			// stub
		}
		
		public function disconnectPeerFromAllPeers( $peerID:String ):void
		{
			// stub
		}

		//--//////////////////////////////////////////////////
		//--//// DISPOSE
		
		public function dispose():void
		{
			// stub
		}
	}
}