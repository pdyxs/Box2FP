package net.box2fp
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
	
	/**
	 * A Flashpunk world which automatically creates and manages a Box2D world within it
	 */
	public class Box2DWorld extends World
	{
		/**
		 * Constructor.
		 */
		public function Box2DWorld()
		{
			super();
		}
		
		/**
		 * The Box2D world object
		 */
		public function get b2world():b2World
		{
			return _b2world;
		}
		
		/** The default framerate (use in FP.Engine constructor if the same) */
		public static const DEFAULT_FRAMERATE:Number = 30;
		/** Overridable function for getting the framerate */
		public function get framerate():Number
		{
			return DEFAULT_FRAMERATE;
		}
		
		/** The default pixel/metre scale */
		private static const DEFAULT_SCALE:Number = 30; // pixels per metre
		/** Overridable function for getting the scale of the world */
		public function get scale():Number
		{
			return DEFAULT_SCALE;
		}
		
		/** The default number of position iterations */
		private static const DEFAULT_PITERATIONS:Number = 10; // pixels per metre
		/** Overridable function for getting the number of position iterations */
		protected function get positionIterations():int
		{
			return DEFAULT_PITERATIONS;
		}
		/** The default number of velocity iterations */
		private static const DEFAULT_VITERATIONS:Number = 10; // pixels per metre
		/** Overridable function for getting the number of velocity iterations */
		protected function get velocityIterations():int
		{
			return DEFAULT_VITERATIONS;
		}
		
		/**
		 * Set the gravity of the world
		 */
		public function setGravity(grav:b2Vec2):void
		{
			_b2world.SetGravity(grav);
		}
		
		/**
		 * Update override.
		 * When not paused, updates the b2world.
		 * draws debugging data
		 */
		override public function update():void
		{
			if (!paused)
			{
				b2world.Step(1.0 / framerate, velocityIterations, positionIterations);
				b2world.ClearForces();
			}
			if (debug)
			{
				debug_sprite.x = -camera.x * FP.screen.scale + FP.screen.x;
				debug_sprite.y = -camera.y * FP.screen.scale + FP.screen.y;
				debug_sprite.scaleX = FP.screen.scale;
				debug_sprite.scaleY = FP.screen.scale;
				b2world.DrawDebugData();
			}
			super.update();
		}
		
		/**
		 * Setup debug drawing
		 */
		private function debug_draw():void {
			debug_sprite = new Sprite();
			FP.stage.addChild(debug_sprite);
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			debug_sprite.addChild(dbgSprite);
			dbgDraw.SetSprite(debug_sprite);
			dbgDraw.SetDrawScale(scale);
			dbgDraw.SetFillAlpha(0.5);
			dbgDraw.SetLineThickness(1);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit|
				b2DebugDraw.e_jointBit |
				b2DebugDraw.e_pairBit |
				b2DebugDraw.e_centerOfMassBit);
			b2world.SetDebugDraw(dbgDraw);
		}
		
		/**
		 * Called to set up debugging in the world
		 */
		protected function doDebug():void
		{
			debug_draw();
			debug = true;
		}
		
		/**
		 * Override End function. Finalises debugging.
		 */
		override public function end():void
		{
			if (debug)
				FP.stage.removeChild(debug_sprite);
		}
		
		/** Pauses the game */
		public function pause():void { _paused = true; }
		/** Unpauses the game */
		public function unpause():void { _paused = false; }
		/** The current pause state */
		public function get paused():Boolean { return _paused; }
		
		private var _paused:Boolean = false;
		private var debug:Boolean = false;
		private var debug_sprite:Sprite;
		private var _b2world:b2World = new b2World(new b2Vec2(0.0, 0.0), true);
	}
}