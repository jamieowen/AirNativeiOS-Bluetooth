package com.jamieowen.ane.ios.p2p {
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	
	
	[Event(name="gkSessionChangeState", type="com.jamieowen.ane.ios.p2p.GKSessionEvent")]
	
	[Event(name="gkSessionDidReceiveConnectionRequestFromPeer", type="com.jamieowen.ane.ios.p2p.GKSessionEvent")]
	
	[Event(name="gkSessionDataReceived", type="com.jamieowen.ane.ios.p2p.GKSessionEvent")]
	
	/**
	* Mirrors the iOS GKSession object.
	*
	* @author jamieowen
	*/
	public class GKSession extends EventDispatcher
	{
		private var _p2p:GKPeerToPeer;
		private var _disposed:Boolean;
		
		//--//////////////////////////////////////////////////
		//--//// GETTERS/SETTERS
		
		
		//--//////////////////////////////////////////////////
		//--//// SEARCHING FOR OTHER PEERS
			
		public function get available():Boolean
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return false; }
			
			return _p2p.context.call( "gkSession_get_available") as Boolean;
		}
		
		public function set available($available:Boolean):void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_set_available", $available ); 
		}
		
		//--//////////////////////////////////////////////////
		//--//// INFORMATION ABOUT THE SESSION (read only)
		
 		public function get displayName():String
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return ""; }
			
			return _p2p.context.call( "gkSession_get_displayName") as String;
		}
  		
		public function get peerID():String
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return ""; }
			
			return _p2p.context.call( "gkSession_get_peerID") as String;
		}
		
  		public function get sessionID():String
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return ""; }
			
			return _p2p.context.call( "gkSession_get_sessionID") as String;
		}
		
		public function get sessionMode():uint
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return 0; }
			
			return _p2p.context.call( "gkSession_get_sessionMode") as uint;
		}
		
		//--//////////////////////////////////////////////////
		//--//// WORKING WITH CONNECTED PEERS
		
		public function get disconnectTimeout():Number
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return 0; }
			
			return _p2p.context.call( "gkSession_get_disconnectTimeout") as Number;
		}
		

		public function set disconnectTimeout( $timeout:Number ):void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_set_disconnectTimeout", $timeout );
		}
				
		
  
		/**
		* Class Constructor Description
		*/
		public function GKSession( $p2p:GKPeerToPeer )
		{
			if( !GKPeerToPeer.CREATE_GK_OBJECTS ) { throw new Error("GKSession objects must be instantiated via a GKPeerToPeer object"); return; }
			
			_disposed = false;
			_p2p = $p2p;
			_p2p.context.addEventListener( StatusEvent.STATUS, onExtensionContextStatus );
		}
		
		//--//////////////////////////////////////////////////
		//--//// METHODS
		
		
		//--//////////////////////////////////////////////////
		//--//// CREATING A SESSION
		
		/**public function initWithSessionID( $id:String, $displayName:String, $sessionMode:uint = GKSessionMode.PEER ):void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			if( $sessionMode != GKSessionMode.CLIENT || $sessionMode != GKSessionMode.PEER || $sessionMode != GKSessionMode.SERVER )
				throw new Error( "Invalid sessionMode type");
				
			_p2p.context.call( "gkSession_initWithSessionID", $id, $displayName, $sessionMode );
		}**/
		
		//--//////////////////////////////////////////////////
		//--//// OBTAINING INFORMATION ABOUT PEERS
		
		public function peersWithConnectionState( $state:uint = GKPeerConnectionState.AVAILABLE ):Vector.<String>
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return null; }
			
			return _p2p.context.call( "gkSession_peersWithConnectionState", $state ) as Vector.<String>;
		}
		
		public function displayNameForPeer($peerID:String):String
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return ""; }
			
			return _p2p.context.call( "gkSession_displayNameForPeer", $peerID ) as String;
		}
		
		//--//////////////////////////////////////////////////
		//--//// CONNECTING TO A REMOTE PEER
		
		/**public function connectToPeer($peerID:String, $timeout:Number):void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_connectToPeer", $peerID, $timeout );
		}
		
		public function cancelConnectToPeer($peerID:String):void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_cancelConnectToPeer", $peerID );
		}**/
		
		//--//////////////////////////////////////////////////
		//--//// RECEIVING CONNECTIONS FROM REMOTE PEER
		
		/**public function acceptConnectionFromPeer( $peerID:String ):Boolean
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return false; }
			
			// if the result is false - an error should be thrown - this is not supported yet.
			var result:Boolean = _p2p.context.call( "gkSession_acceptConnectionFromPeer", $peerID ) as Boolean;
			if( !result )
			{
				// TODO : HANDLE ERROR CORRECTLY
				//var error:Object = getLastNSError();
				//if( error ) dispatchEvent( new GKSessionErrorEvent(GKSessionErrorEvent.ACCEPT_CONNECTION_ERROR,error["code"], error["message"], $peerID ));
			}
			
			return result;
		}
		

		public function denyConnectionFromPeer( $peerID:String ):void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_denyConnectionFromPeer", $peerID );
		}**/
		
		//--//////////////////////////////////////////////////
		//--//// WORKING WITH CONNECTED PEERS
		
		/**public function sendData( $data:String, $peers:Vector.<String>, $dataMode:uint = 0 ):Boolean
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return false; }
			
			if( $peers == null ) throw new Error( "Peers cannot be null");
			else if( $dataMode != GKSendDataMode.RELIABLE || $dataMode != GKSendDataMode.UNRELIABLE ) throw new Error( "Invalid dataMode");
			
			// if the result is false - an error should be thrown - this is not supported yet.
			var result:Boolean = _p2p.context.call( "gkSession_sendData", $data, $peers, $dataMode  ) as Boolean; 
			if( !result )
			{
			// TODO : HANDLE ERROR CORRECTLY.
			//	var error:Object = getLastNSError();
			//	if( error ) dispatchEvent( new GKSessionErrorEvent(GKSessionErrorEvent.SEND_DATA_ERROR, error["code"], error["message"]));
			}
			
			return result;
		}**/
		
		public function sendDataToAllPeers( $data:String, $dataMode:uint = 0 ):Boolean
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return false; }
			
			if( $dataMode != GKSendDataMode.RELIABLE && $dataMode != GKSendDataMode.UNRELIABLE ) throw new Error( "Invalid dataMode");
			 
			var result:Boolean = _p2p.context.call( "gkSession_sendDataToAllPeers", $data, $dataMode  ) as Boolean;
			
			if( !result )
			{
			// TODO : HANDLE ERROR CORRECTLY.
			//	var error:Object = getLastNSError();
			//	if( error ) dispatchEvent( new GKSessionErrorEvent(GKSessionErrorEvent.SEND_DATA_TO_ALL_ERROR,error["code"], error["message"]));
			}
			
			return result;
		}
		
		
		public function disconnectFromAllPeers():void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_disconnectFromAllPeers");
		}
		
		/**public function disconnectPeerFromAllPeers( $peerID:String ):void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_disconnectPeerFromAllPeers", $peerID );
		}**/

		//--//////////////////////////////////////////////////
		//--//// DISPOSE
		
		public function dispose():void
		{
			if( _disposed ) { throw new Error("GKSession has been disposed"); return; }
			
			_p2p.context.call( "gkSession_dispose");
			_p2p.context.removeEventListener( StatusEvent.STATUS, onExtensionContextStatus );
			_p2p.setGKSession(null);
			_p2p = null;
		}
		
		//--//////////////////////////////////////////////////
		//--//// EVENT HANDLERS
		
		protected function onExtensionContextStatus( $event:StatusEvent ):void
		{ 
			// for debugging
			dispatchEvent( $event );
			
			var peerID:String;
			var error:Object;
			var args:Array;
			switch( $event.code )
			{
				case GKSessionEvent.DID_CHANGE_STATE :
					// split the state // added a {&} between peerid and state - if either contain "{&}" in the peerID or state - this will cause errors.
					args = $event.level.split("{&}");
					peerID = args[1] as String;
					var state:uint = parseInt(args[0],10); 
					var ev:GKSessionEvent = new GKSessionEvent(GKSessionEvent.DID_CHANGE_STATE,peerID,state);
					dispatchEvent( ev );
					
					break;
					
				case GKSessionErrorEvent.CONNECTION_WITH_PEER_FAILED :
					// parse error
					args = $event.level.split("{&}");
					peerID = args[0]; 
					error = {};
					error["code"] = args[1];
					error["message"] = args[2];
					
					dispatchEvent( new GKSessionErrorEvent(GKSessionErrorEvent.CONNECTION_WITH_PEER_FAILED, error["code"], error["message"],peerID));
					break;
					
				case GKSessionErrorEvent.DID_FAIL_WITH_ERROR :
					args = $event.level.split("{&}");
					error = {};
					error["code"] = args[0];
					error["message"] = args[1];					
					
					dispatchEvent( new GKSessionErrorEvent(GKSessionErrorEvent.DID_FAIL_WITH_ERROR, error["code"], error["message"]));
					break;
					
				case GKSessionEvent.DID_RECEIVE_CONNECTION_REQUEST_FROM_PEER :
					peerID = $event.level;
					dispatchEvent( new GKSessionEvent(GKSessionEvent.DID_RECEIVE_CONNECTION_REQUEST_FROM_PEER, peerID));
					
					break;
					
				case GKSessionEvent.DATA_RECEIVED :
					args = $event.level.split("{&}");
					peerID = args[1];
					var data:String = args[0];
					dispatchEvent( new GKSessionEvent(GKSessionEvent.DATA_RECEIVED, peerID, 0, data ));
					
					break;
			}
		}
	}
}