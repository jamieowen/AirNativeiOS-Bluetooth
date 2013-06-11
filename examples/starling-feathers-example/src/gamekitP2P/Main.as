package gamekitP2P {
	import gamekitP2P.screens.SessionConnectedScreen;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import gamekitP2P.screens.PeerPickerWaitScreen;
	import gamekitP2P.data.P2PData;
	import gamekitP2P.screens.ClientConnectionScreen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.themes.MetalWorksMobileTheme;

	import gamekitP2P.screens.ConnectOptionsScreen;
	import gamekitP2P.screens.HostConnectionScreen;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class Main extends Sprite
	{
		public static const CONNECT_OPTIONS_SCREEN:String = "connectOptionsScreen";
		public static const HOST_CONNECTION_SCREEN:String = "hostConnectionScreen";
		public static const CLIENT_CONNECTION_SCREEN:String = "clientConnectionScreen";
		public static const PEERPICKER_WAIT_SCREEN:String = "peerPickerWaitScreen";
		 
		public static const SESSION_CONNECTED_SCREEN:String = "sessionConnectedScreen";
		
		//private static const TILED_IMAGE:String = "tiledImage";
		
		private var _p2pData:P2PData;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private var _theme:MetalWorksMobileTheme;
		private var _navigator:ScreenNavigator;
		private var _transitions:ScreenSlidingStackTransitionManager;

		private function addedToStageHandler(event:Event):void
		{
			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);

			this._theme = new MetalWorksMobileTheme();

			this._navigator = new ScreenNavigator();
			_transitions = new ScreenSlidingStackTransitionManager(this._navigator);
			this._navigator.addEventListener(Event.CHANGE, navigator_changeHandler);
			
			this.addChild(this._navigator);
			
			_p2pData = new P2PData();
			
			this._navigator.addScreen(CONNECT_OPTIONS_SCREEN, new ScreenNavigatorItem(ConnectOptionsScreen,null,{data:_p2pData}));
			this._navigator.addScreen(HOST_CONNECTION_SCREEN, new ScreenNavigatorItem(HostConnectionScreen,null,{data:_p2pData}));
			this._navigator.addScreen(CLIENT_CONNECTION_SCREEN, new ScreenNavigatorItem(ClientConnectionScreen,null,{data:_p2pData}));
			this._navigator.addScreen(PEERPICKER_WAIT_SCREEN, new ScreenNavigatorItem(PeerPickerWaitScreen,null,{data:_p2pData}));
			this._navigator.addScreen(SESSION_CONNECTED_SCREEN, new ScreenNavigatorItem(SessionConnectedScreen,null,{data:_p2pData}));

			this._navigator.showScreen(CONNECT_OPTIONS_SCREEN);
		}

		private function navigator_changeHandler(event:Event):void
		{
			
		}

		private function stage_resizeHandler(event:ResizeEvent):void
		{
			//this.layout(event.width, event.height);
		}
	}
}
