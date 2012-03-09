package com.jamieowen.ane.ios.p2p {
	import flash.external.ExtensionContext;
	
	/**
	* Class Description
	*
	* @author jamieowen
	*/
	public class GKPeerToPeer
	{
		/** Used to prevent instantiation of GKSession or GKPeerPickerController objects outside this class.**/
		internal static var CREATE_GK_OBJECTS:Boolean = false;
		
		private static const EXTENSION_ID:String = "com.jamieowen.ane.ios.p2p.GKPeerToPeer";
		
		private var _context:ExtensionContext;
		
		private var _session:GKSession;
		
		private var _picker:GKPeerPickerController;
		
		internal function get context():ExtensionContext
		{
			return _context;
		}
		
		public function get picker():GKPeerPickerController
		{
			return _picker;	
		}
		
		public function get session():GKSession
		{
			return _session;
		}
		
		/**
		* Class Constructor Description
		*/
		public function GKPeerToPeer()
		{
			_context = ExtensionContext.createExtensionContext( EXTENSION_ID, null );
		}
		
		/**
		 * Creates a new GKSession object on the native os. If one already exists it returns that.
		 */
		public function createGKSession():GKSession
		{
			if( _session ) return _session;
			
			CREATE_GK_OBJECTS = true;
			_session = new GKSession(this);
			CREATE_GK_OBJECTS = false;
			
			_context.call( "gkp2p_createGKSession");
			
			return _session;
		}
		
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
			if( _session ) throw new Error("An existing session is open. Dispose the session before creating a GKPeerPickerController");
			
			if( _picker ) return _picker;
			
			CREATE_GK_OBJECTS = true;
			_picker  = new GKPeerPickerController(this);
			CREATE_GK_OBJECTS = false;
			
			// init the controller.
			_context.call( "gkp2p_createGKPeerPickerController");
			
			return _picker;
		}
		
		/** Used to set the GKSession from the GKPeerPickerController object ( when a user connects via the iOS ui ). Or when calling dispose() on the GKSession object.**/
		internal function setGKSession( $session:GKSession ):void
		{
			_session = $session;
		}
		
		/** Used when calling dispose() on the GKPeerPickerController object.**/
		internal function setGKPeerPickerController( $picker:GKPeerPickerController ):void
		{
			_picker = $picker;
		}
		
		/**
		 * Disposes of this and any GKSession or GKPeerPickerController objects.
		 */
		public function dispose():void
		{
			if( _picker ) _picker.dispose();
			if( _session ) _session.dispose();
			
			_context.dispose();
			_context = null;
		}
		
		

		
	}
}