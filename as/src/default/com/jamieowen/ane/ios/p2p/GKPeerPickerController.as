package com.jamieowen.ane.ios.p2p {
	import flash.events.EventDispatcher;
	
	[Event(name="gkPeerPickerDidConnectPeer", type="com.jamieowen.ane.ios.p2p.GKPeerPickerControllerEvent")]
	
	[Event(name="gkPeerPickerControllerDidCancel", type="com.jamieowen.ane.ios.p2p.GKPeerPickerControllerEvent")]
	
	/**
	* Class Description
	*
	* @author jamieowen
	*/
	public class GKPeerPickerController extends EventDispatcher
	{
		
		/**
		* Class Constructor Description
		*/
		public function GKPeerPickerController($p2p:GKPeerToPeer)
		{
			// stub
		}
		
		public function show():void
		{
			// stub
		}
		
		public function dismiss():void
		{
			// stub
		}
		
		// leave out for now.
		/**
		public function get connectionTypesMask():uint
		{
			// stub
		}
		
		public function set connectionTypesMask( $mask:uint ):void
		{
			// stub
		}**/
		
		public function get visible():Boolean
		{
			// stub
			return false;
		}
		
		public function dispose():void
		{
			// stub
		}
	}
}