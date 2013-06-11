package gamekitP2P.events {
	import flash.events.Event;

	/**
	 * @author jamieowen
	 */
	public class P2PDataEvent extends Event
	{
		public static const PEER_PICKER_CANCELLED:String = "peerPickerCancelled";
		public static const SESSION_CREATED:String = "sessionCreated";
		
		public static const DATA_RECEIVED:String = "dataReceived";
		
		public function P2PDataEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
