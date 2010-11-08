package fabulaexmachina.box2fp
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import fabulaexmachina.box2fp.graphics.SuperGraphiclist;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class Box2DEntity extends Entity implements IBox2DEntity
	{	
		//Reusable
		protected static var fixture:b2FixtureDef = new b2FixtureDef();
		
		public var body:b2Body;
		protected var _world:Box2DWorld;
		
		public function Box2DEntity(x:Number=0, y:Number=0, w:uint = 1, 
								h:uint = 1, type:int = 0, group:int = 0, 
								category:int = 0, collmask:int = 0, friction:Number = 0.3, 
								density:Number = 1, restitution:Number = 1)
		{
			super(x, y, new SuperGraphiclist);
			
			_world = FP.world as Box2DWorld;
			
			var bodyDef:b2BodyDef = new b2BodyDef;
			bodyDef.position.Set((x + w/2) / _world.scale, (y + h/2) / _world.scale);
			bodyDef.type = type;
			
			width = w;
			height = h;
			
			if (_world != null)
			{
				body = _world.world.CreateBody(bodyDef);
			} else {
				FP.console.paused = true;
				FP.console.log("ERROR: Box2DEntity created in non Box2DWorld"); 
			}
			
			buildShapes(friction, density, restitution, group, category, collmask);
		}
		
		override public function added():void
		{
			super.added();
			body.SetUserData(this);
		}
		
		public function buildShapes(friction:Number, 
				density:Number, restitution:Number,
				group:int, category:int, collmask:int):void { }
		
		override public function update():void
		{
			if (body.GetType() != b2Body.b2_staticBody)
			{
				var pos:b2Vec2 = body.GetPosition();
				x = pos.x * _world.scale - width/2 + 1;
				y = pos.y * _world.scale - height/2 + 1;
				angleRads = body.GetAngle();
			}
			super.update();
		}
		
		public function remove():void
		{
			if (_world)
			{
				_world.world.DestroyBody(body);
				_world.remove(this);
			}
		}
		
		public function get angle():Number
		{
			return body.GetAngle() * 180.0 / Math.PI;
		}
		
		public function set angle(angle:Number):void
		{
			body.SetAngle(angle * Math.PI / 180.0);
			(graphic as SuperGraphiclist).angle = -angle;
			if (angle != 0)
				(graphic as SuperGraphiclist).smooth = true;
		}
		
		public function get angleRads():Number
		{
			return body.GetAngle();
		}
		
		public function set angleRads(angle:Number):void
		{
			body.SetAngle(angle);
			(graphic as SuperGraphiclist).angle = -angle * 180.0 / Math.PI;
			if (angle != 0)
				(graphic as SuperGraphiclist).smooth = true;
		}
		
		public function get alpha():Number
		{
			return (graphic as SuperGraphiclist).alpha;
		}
		public function set alpha(val:Number):void
		{
			(graphic as SuperGraphiclist).alpha = val;
		}
		
		public function get X():Number { return x; }
		public function set X(v:Number):void { x = v; }
		public function get Y():Number { return y; }
		public function set Y(v:Number):void { y = v; }
		public function get Width():Number { return width; }
		public function set Width(v:Number):void { width = v; }
		public function get Height():Number { return height; }
		public function set Height(v:Number):void { height = v; }
	}
}