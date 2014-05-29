/**
 * Created by oreva on 28.05.2014.
 */
package bb.modules
{
	/**
	 */
	public class BBEvent
	{
		public var stopPropagation:Boolean = false;

		private var _name:String;
		private var _param:Object;
		private var _sender:Object;

		/**
		 */
		public function BBEvent(p_name:String, p_param:Object = null, p_sender:Object = null)
		{
			_name = p_name;
			_param = p_param;
			_sender = p_sender;
		}

		public function get name():String
		{
			return _name;
		}

		public function get param():Object
		{
			return _param;
		}

		public function get sender():Object
		{
			return _sender;
		}

		/**
		 */
		internal function dispose():void
		{
			_name = null;
			_param = null;
			_sender = null;

			put(this);
		}

		//

		static private var _pool:Vector.<BBEvent> = new <BBEvent>[];
		static private var _size:int = 0;

		static public function get(p_name:String, p_param:Object = null, p_sender:Object = null):BBEvent
		{
			var event:BBEvent;

			if (_size > 0)
			{
				event = _pool[--_size];
				event._name = p_name;
				event._param = p_param;
				event._sender = p_sender;
			}
			else event = new BBEvent(p_name, p_param, p_sender);

			return event;
		}

		/**
		 */
		static private function put(p_event:BBEvent):void
		{
			_pool[_size++] = p_event;
		}

		/**
		 * Rid of all pooled objects.
		 */
		static public function rid():void
		{
			for (var i:int = 0; i < _size; i++)
			{
				_pool[i] = null;
			}

			_pool.length = 0;
			_size = 0;
		}
	}
}
