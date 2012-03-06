package com.jamieowen.ane.ios.p2p
{
	import flash.events.Event;
	
	/**
	* Events dispatched from the <code>GKSession</code> object.
	*
	* @author jamieowen
	*/
	public class GKSessionEvent extends Event
	{
		// (equivalent to GKSessionDelegate methods)
		public static const DID_CHANGE_STATE:String 						= "gkSessionChangeState";
		public static const DID_RECEIVE_CONNECTION_REQUEST_FROM_PEER:String = "gkSessionDidReceiveConnectionRequestFromPeer";
				
		// (equivalent to GKSession.setDataReceiveHandler)
		public static const DATA_RECEIVED:String							= "gkSessionDataReceived";
		
		
		public var peerID:String;
		
		// session state / passed with DID_CHANGE_STATE
		public var sessionState:uint;
				
		// data 
		public var data:String;
		
		/**
		* An event to handle all error and standard events.
		*/
		public function GKSessionEvent($type:String, $peerID:String, $sessionState:uint = -1, $data:String = null )
		{
			super($type);
			
			peerID 			= $peerID;
			sessionState 	= $sessionState;
			data			= $data;
		}
		
		override public function clone():Event
		{
			var ev:GKSessionEvent = new GKSessionEvent(type,peerID,sessionState);
			return ev;
		}
	}
}