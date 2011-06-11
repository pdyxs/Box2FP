package net.box2fp
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import net.box2fp.graphics.SuperGraphiclist;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * An Flashpunk entity which contains a Box2D body, governed by both worlds.
	 */
	public class Box2DEntity extends Entity implements IBox2DEntity
	{
		/**
		 * Constructor. Sets the graphic to a SuperGraphiclist
		 * @param x				x co-ord (pixels)
		 * @param y				y co-ord (pixels)
		 * @param w				width (pixels)
		 * @param h				height (pixels)
		 * @param b2Type		box2d body type (dynamic, kinematic, static)
		 * @param group			box2d collision group (ignored if 0)
		 * @param category		box2d collision category (ignored if 0)
		 * @param collmask		box2d collision mask (ignored if 0)
		 * @param friction
		 * @param density
		 * @param restitution	bounciness
		 */
		public function Box2DEntity(x:Number=0, y:Number=0, w:uint = 1, 
								h:uint = 1, b2Type:int = 0, group:int = 0, 
								category:int = 0, collmask:int = 0, friction:Number = 0.3, 
								density:Number = 1, restitution:Number = 1)
		{
			super(x, y, new SuperGraphiclist);
			
			_Box2DOptions = { type: b2Type, group: group, category: category, collmask: collmask,
								friction: friction, density: density, restitution: restitution };
			
			width = w;
			height = h;
		}
		private var _Box2DOptions:Object;
		
		/** Sets the user data of the Box2D body to the Flashpunk entity */
		override public function added():void
		{
			super.added();
			
			if (box2dworld != null)
			{
				makeBody(box2dworld.b2world);
			} else {
				FP.console.enable();
				FP.console.paused = true;
				FP.console.log("ERROR: Box2DEntity created in non Box2DWorld"); 
			}
			
			body.SetUserData(this);
		}
		
		/**
		 * Makes the body if it hasn't already been made.
		 * Note that you can call this in the entity's constructor if you'd like and supply the box2d world
		 * yourself to create the box2d shapes in the frame the object is built
		 */
		protected function makeBody(world:b2World):void
		{
			if (_body == null)
			{
				var bodyDef:b2BodyDef = new b2BodyDef;
				bodyDef.position.Set((x + width/2) / box2dworld.scale, (y + height/2) / box2dworld.scale);
				bodyDef.type = _Box2DOptions.type;
				
				_body = world.CreateBody(bodyDef);
				
				buildShapes(_Box2DOptions.friction, _Box2DOptions.density, 
					_Box2DOptions.restitution, _Box2DOptions.group, _Box2DOptions.category, 
					_Box2DOptions.collmask);
				_Box2DOptions = null;
			}
		}
		
		/** Get the Box2D body object */
		public function get body():b2Body
		{
			return _body;
		}
		
		/** Get the Box2D world the object is in */
		protected function get box2dworld():Box2DWorld
		{
			if (FP.world is Box2DWorld) 
				return FP.world as Box2DWorld;
			return null;
		}
		
		/** 
		 * Overridable function to create Box2D shapes within the constructor 
		 * @param group			box2d collision group (ignore if 0)
		 * @param category		box2d collision category (ignore if 0)
		 * @param collmask		box2d collision mask (ignore if 0)
		 * @param friction
		 * @param density
		 * @param restitution	bounciness
		 */
		public function buildShapes(friction:Number, 
				density:Number, restitution:Number,
				group:int, category:int, collmask:int):void { }
		
		/**
		 * Overrided Update.
		 * Move the flashpunk entity to the co-ordinates specified by the 
		 * 	Box2D body. 
		 */
		override public function update():void
		{
			if (body && body.GetType() != b2Body.b2_staticBody)
			{
				var pos:b2Vec2 = body.GetPosition();
				x = pos.x * box2dworld.scale - width/2 + 1;
				y = pos.y * box2dworld.scale - height/2 + 1;
				angleRads = body.GetAngle();
			}
			super.update();
		}
		
		/**
		 * Remove the object from both worlds.
		 */
		public function remove():void
		{
			if (box2dworld)
			{
				box2dworld.b2world.DestroyBody(body);
				box2dworld.remove(this);
			}
		}
		
		/**
		 * Get the Box2D angle in degrees
		 */
		public function get angle():Number
		{
			return body.GetAngle() * 180.0 / Math.PI;
		}
		
		/**
		 * Set the Box2D angle in degrees (opposite of Flashpunk angle)
		 */
		public function set angle(angle:Number):void
		{
			body.SetAngle(angle * Math.PI / 180.0);
			(graphic as SuperGraphiclist).angle = -angle;
			if (angle != 0)
				(graphic as SuperGraphiclist).smooth = true;
		}
		
		/**
		 * Get the Box2D angle in radians
		 */
		public function get angleRads():Number
		{
			return body.GetAngle();
		}
		
		/**
		 * Set the Box2D angle in radians (opposite of Flashpunk angle)
		 */
		public function set angleRads(angle:Number):void
		{
			body.SetAngle(angle);
			(graphic as SuperGraphiclist).angle = -angle * 180.0 / Math.PI;
			if (angle != 0)
				(graphic as SuperGraphiclist).smooth = true;
		}
		
		public function get X():Number { return x; }
		public function set X(v:Number):void { x = v; }
		public function get Y():Number { return y; }
		public function set Y(v:Number):void { y = v; }
		public function get Width():Number { return width; }
		public function set Width(v:Number):void { width = v; }
		public function get Height():Number { return height; }
		public function set Height(v:Number):void { height = v; }
		
		private var _body:b2Body = null;
	}
}