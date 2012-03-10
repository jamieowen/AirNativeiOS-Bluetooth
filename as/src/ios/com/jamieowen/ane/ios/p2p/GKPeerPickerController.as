package com.jamieowen.ane.ios.p2p {
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	
	[Event(name="gkPeerPickerDidConnectPeer", type="com.jamieowen.ane.ios.p2p.GKPeerPickerControllerEvent")]
	
	[Event(name="gkPeerPickerControllerDidCancel", type="com.jamieowen.ane.ios.p2p.GKPeerPickerControllerEvent")]
	
	/**
	* Class Description
	*
	* @author jamieowen
	*/
	public class GKPeerPickerController extends EventDispatcher
	{
		private var _p2p:GKPeerToPeer;
		private var _disposed:Boolean;
		private var _shown:Boolean;
		/**
		* Class Constructor Description
		*/
		public function GKPeerPickerController($p2p:GKPeerToPeer)
		{
			if( !GKPeerToPeer.CREATE_GK_OBJECTS ) { throw new Error("GKPeerPickerController objects must be instantiated via a GKPeerToPeer object"); return; }
			
			_disposed = false;
			_shown = false;
			
			_p2p = $p2p;
			_p2p.context.addEventListener( StatusEvent.STATUS, onExtensionContextStatus );
		}
		
		public function show():void
		{
			if( _shown ) return;
			if( _disposed ) { throw new Error("Picker has been disposed"); return; }
			
			_shown = true;
			_p2p.context.call( "gkPeerPickerController_show");
		}
		
		public function dismiss():void
		{
			if( !_shown ) return;
			if( _disposed ) { throw new Error("Picker has been disposed"); return; }
			
			_shown = false;
			_p2p.context.call( "gkPeerPickerController_dismiss");
		}
		
		// leave out for now.
		/**
		public function get connectionTypesMask():uint
		{
			return _p2p.context.call( "gkPeerPickerController_get_connectionTypesMask") as uint;
		}
		
		public function set connectionTypesMask( $mask:uint ):void
		{
			if( $mask != GKPeerPickerConnectionType.NEARBY || $mask != GKPeerPickerConnectionType.ONLINE ) 
				throw new Error( "Invalid connectionTypesMask value.");
				
			_p2p.context.call( "gkPeerPickerController_set_connectionTypesMask", $mask );
		}**/
		
		public function get visible():Boolean
		{
			if( _disposed ) { throw new Error("Picker has been disposed"); return false; }
			
			return _p2p.context.call( "gkPeerPickerController_get_visible") as Boolean;
		}
		
		public function dispose():void
		{
			if( _disposed ) { throw new Error("Picker has been disposed"); return; }
			
			_p2p.context.call( "gkPeerPickerController_dispose");
			_p2p.context.removeEventListener( StatusEvent.STATUS, onExtensionContextStatus );
			_p2p.setGKPeerPickerController(null);
			_p2p = null;
			_disposed = true;
		}
		
		protected function onExtensionContextStatus( $event:StatusEvent ):void
		{
			switch( $event.code )
			{
				case GKPeerPickerControllerEvent.DID_CONNECT_PEER :
					// we have connected = create the GKSession
					GKPeerToPeer.CREATE_GK_OBJECTS = true;
					var session:GKSession = new GKSession(_p2p);
					GKPeerToPeer.CREATE_GK_OBJECTS = false;
					_p2p.setGKSession(session);
					
					var peerID:String = $event.level;
					dispatchEvent( new GKPeerPickerControllerEvent(GKPeerPickerControllerEvent.DID_CONNECT_PEER, peerID ));
					
					break;
					
				case GKPeerPickerControllerEvent.CONTROLLER_DID_CANCEL :
					// set shown to false - calling dismiss twice on the ExtensionContext crashes the app.
					_shown = false;
					dispatchEvent( new GKPeerPickerControllerEvent(GKPeerPickerControllerEvent.CONTROLLER_DID_CANCEL));
					break;
			}
		}
	}
}