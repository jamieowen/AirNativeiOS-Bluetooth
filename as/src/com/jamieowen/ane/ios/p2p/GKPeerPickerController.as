package com.jamieowen.ane.ios.p2p {
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	
	/**
	* Class Description
	*
	* @author jamieowen
	*/
	public class GKPeerPickerController extends EventDispatcher
	{
		private var _p2p:GKPeerToPeer;
		
		/**
		* Class Constructor Description
		*/
		public function GKPeerPickerController($p2p:GKPeerToPeer)
		{
			if( !GKPeerToPeer.CREATE_GK_OBJECTS ) throw new Error("GKPeerPickerController objects must be instantiated via a GKPeerToPeer object");
			
			_p2p = $p2p;
			_p2p.context.addEventListener( StatusEvent.STATUS, onExtensionContextStatus );
		}
		
		public function show():void
		{
			_p2p.context.call( "gkPeerPickerController_show");
		}
		
		public function dismiss():void
		{
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
			return _p2p.context.call( "gkPeerPickerController_get_visible") as Boolean;
		}
		
		internal function dispose():void
		{
			_p2p.context.call( "gkPeerPickerController_dispose");
			_p2p.context.removeEventListener( StatusEvent.STATUS, onExtensionContextStatus );
			_p2p.setGKPeerPickerController(null);
			_p2p = null;
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
					dispatchEvent( new GKPeerPickerControllerEvent(GKPeerPickerControllerEvent.CONTROLLER_DID_CANCEL));
					break;
			}
		}
	}
}