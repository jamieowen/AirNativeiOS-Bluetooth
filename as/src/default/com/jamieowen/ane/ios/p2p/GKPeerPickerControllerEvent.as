package com.jamieowen.ane.ios.p2p
{
	import flash.events.Event;
	
	/**
	* Events dispatched from GKPeerPickerController 
	* - These events are essentially the methods found on the iOS GKPeerPickerControllerDelegate :
	* https://developer.apple.com/library/ios/#DOCUMENTATION/GameKit/Reference/GKPeerPickerControllerDelegate_Protocol/Reference/Reference.html
	*
	* @author jamieowen
	*/
	public class GKPeerPickerControllerEvent extends Event
	{
		public static const DID_CONNECT_PEER:String 				= "gkPeerPickerDidConnectPeer";
		public static const CONTROLLER_DID_CANCEL:String			= "gkPeerPickerControllerDidCancel";
		
		// leave out the connection type related methods found in iOS GKPeerPickerControllerDelegate
		//public static const DID_SELECT_CONNECTION_TYPE:String		= "gkPeerPickerDidSelectConnectionType";
		
		public var peerID:String;
		/**
		* Class Constructor Description
		*/
		public function GKPeerPickerControllerEvent($type:String,$peerID:String = null )
		{
			super($type);
			
			peerID = $peerID;
		}
	}
}