package com.jamieowen.ane.ios.p2p
{
	import flash.events.Event;
	/**
	* Class Description
	*
	* @author jamieowen
	*/
	public class GKSessionErrorEvent extends Event
	{
		// triggered from calls to GKSession methods - dispatched from actionscript GKSession class as a equivalent to Obj-C NSError
		public static const SEND_DATA_ERROR:String 				= "gkSessionSendDataError";
		public static const SEND_DATA_TO_ALL_ERROR:String 		= "gkSessionSendDataToAllError";
		public static const ACCEPT_CONNECTION_ERROR:String		= "gkSessionAcceptConnectionError";
		
		// (equivalent to GKSessionDelegate methods) - dispatched from ExtensionContext
		public static const CONNECTION_WITH_PEER_FAILED:String 	= "gkSessionConnectionWithPeerFailed";
		public static const DID_FAIL_WITH_ERROR:String			= "gkSessionDidFailWithError";
		
		public var peerID:String;
	
		public var code:uint;
		public var message:String;
		
		/**
		* Class Constructor Description
		*/
		public function GKSessionErrorEvent($type:String, $code:uint, $message:String, $peerID:String = null )
		{
			super($type);
			
			peerID 		= $peerID;
			code 		= $code;
			message 	= $message;
		}
	}
}