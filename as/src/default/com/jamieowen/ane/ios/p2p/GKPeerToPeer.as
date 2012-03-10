package com.jamieowen.ane.ios.p2p {
	import flash.external.ExtensionContext;
	
	/**
	* Class Description
	*
	* @author jamieowen
	*/
	public class GKPeerToPeer
	{
		
		internal function get context():ExtensionContext
		{
			// stub
			return null;
		}
		
		public function get picker():GKPeerPickerController
		{
			// stub
			return null;
		}
		
		public function get session():GKSession
		{
			// stub
			return null;
		}
		
		/**
		* Class Constructor Description
		*/
		public function GKPeerToPeer()
		{
		
		}
		
		/**
		 * Creates a new GKSession object on the native os. If one already exists it returns that.
		 */
		/**public function createGKSession():GKSession
		{
			// stub
			return null;
		}**/
		
		/**
		 * Creates a GKPeerPickerController object on the native os.  If one already exists it returns that.
		 * An independent GKSession must not exist when calling this so call dispose() on any existing GKSession.
		 * 
		 * A new GKSession is only created when the GKPeerPickerController object dispatches the GKPeerPickerControllerEvent.DID_CONNECT_PEER event
		 * Wait for this event to be dispatched before accessing the session object.
		 * 
		 * After receiving the GKPeerPickerControllerEvent.DID_CONNECT_PEER event the picker can be hidden and disposed of.
		 */
		public function createGKPeerPickerController():GKPeerPickerController
		{
			// stub
			return null;
		}
		
		/** Used to set the GKSession from the GKPeerPickerController object ( when a user connects via the iOS ui ). Or when calling dispose() on the GKSession object.**/
		internal function setGKSession( $session:GKSession ):void
		{
			// stub
		}
		
		/** Used when calling dispose() on the GKPeerPickerController object.**/
		internal function setGKPeerPickerController( $picker:GKPeerPickerController ):void
		{
			// stub
		}
		
		/**
		 * Disposes of this and any GKSession or GKPeerPickerController objects.
		 */
		public function dispose():void
		{
			// stub
		}
	}
}