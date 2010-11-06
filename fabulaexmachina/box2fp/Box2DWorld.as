package fabulaexmachina.box2fp
{
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Draw;
	
	public class Box2DWorld extends World
	{
		public var world:b2World = new b2World(new b2Vec2(0.0, 0.0), true);
		
		public static const DEFAULT_FRAMERATE:Number = 30;
		public static const DEFAULT_SCALE:Number = 30; // pixels per metre
		
		protected function get iterations():int
		{
			return 10;
		}
		
		public function get framerate():Number
		{
			return DEFAULT_FRAMERATE;
		}
		
		public function get scale():Number
		{
			return DEFAULT_SCALE;
		}
		
		public function get viewScale():Number
		{
			return FP.screen.scale;
		}
		
		public function setGravity(grav:b2Vec2):void
		{
			world.SetGravity(grav);
		}
		
		public function Box2DWorld()
		{
			super();
		}
		
		override public function update():void
		{
			if (!paused)
			{
				world.Step(1 / framerate, iterations, iterations);
				world.ClearForces();
			}
			if (debug)
			{
				debug_sprite.x = -camera.x * viewScale;
				debug_sprite.y = -camera.y * viewScale;
				debug_sprite.scaleX = viewScale;
				debug_sprite.scaleY = viewScale;
				world.DrawDebugData();
			}
			super.update();
		}
		
		//Debug drawing
		public function debug_draw():void {
			debug_sprite = new Sprite();
			FP.stage.addChild(debug_sprite);
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			debug_sprite.addChild(dbgSprite);
			dbgDraw.SetSprite(debug_sprite); // was dbgDraw.m_sprite=m_sprite;
			dbgDraw.SetDrawScale(scale); // was dbgDraw.m_drawScale=30;
			//dbgDraw.SetAlpha(1); // was dbgDraw.m_alpha=1;
			dbgDraw.SetFillAlpha(0.5); // was dbgDraw.m_fillAlpha=0.5;
			dbgDraw.SetLineThickness(1); // was dbgDraw.m_lineThickness=1;
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit|
				b2DebugDraw.e_jointBit |
				b2DebugDraw.e_pairBit |
				b2DebugDraw.e_centerOfMassBit);
			world.SetDebugDraw(dbgDraw);
//			FP.stage.setChildIndex(m_sprite, 100);
		}
		
		public function doDebug():void
		{
			debug_draw();
			debug = true;
		}
		
		override public function end():void
		{
			if (debug)
				FP.stage.removeChild(debug_sprite);
		}
		
		public function pause():void { _paused = true; }
		public function unpause():void { _paused = false; }
		public function get paused():Boolean { return _paused; }
		
		public function get groundBody():b2Body { return _groundBody; }
		protected var _groundBody:b2Body = null;
		protected var _paused:Boolean = true;
		
		private var debug:Boolean = false;
		private var debug_sprite:Sprite;
	}
}