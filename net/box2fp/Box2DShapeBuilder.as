package net.box2fp
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;

	/**
	 * Utility class for building shapes.
	 */
	public class Box2DShapeBuilder
	{
		/**
		 * Builds a rectangle
		 * @param body			the body to add the shape to
		 * @param hw			half the width (metres)
		 * @param hh 			half the height (metres)
		 * @param friction
		 * @param density
		 * @param restitution	bounciness
		 * @param group			box2d collision group (ignore if 0)
		 * @param category		box2d collision category (ignore if 0)
		 * @param collmask		box2d collision mask (ignore if 0)
		 */
		public static function buildRectangle(body:b2Body, hw:Number, hh:Number, friction:Number = 0.3, 
			density:Number = 1, restitution:Number = 1, group:int = 0, category:int = 0, collmask:int = 0):b2Fixture
		{
			var fd:b2FixtureDef = new b2FixtureDef();
			fd.density = density;
			fd.shape = b2PolygonShape.AsBox(hw, hh);
			fd.restitution = restitution;
			fd.friction = friction;
			
			if (group != 0)
				fd.filter.groupIndex = group;
			if (category != 0)
				fd.filter.categoryBits = category;
			if (collmask != 0)
				fd.filter.maskBits = collmask;
			
			var fixture:b2Fixture = body.CreateFixture(fd);
			
			return fixture;
		}
		
		/**
		 * Builds a circle
		 * @param body			the body to add the shape to
		 * @param r				radius (metres)
		 * @param friction
		 * @param density
		 * @param restitution	bounciness
		 * @param group			box2d collision group (ignore if 0)
		 * @param category		box2d collision category (ignore if 0)
		 * @param collmask		box2d collision mask (ignore if 0)
		 */
		public static function buildCircle(body:b2Body, r:Number, friction:Number = 0.3, 
			density:Number = 1, restitution:Number = 1, group:int = 0, category:int = 0, collmask:int = 0):b2Fixture
		{
			var fd:b2FixtureDef = new b2FixtureDef();
			fd.density = density;
			fd.shape = new b2CircleShape(r);
			fd.restitution = restitution;
			fd.friction = friction;
			
			if (group != 0)
				fd.filter.groupIndex = group;
			if (category != 0)
				fd.filter.categoryBits = category;
			if (collmask != 0)
				fd.filter.maskBits = collmask;
			
			var fixture:b2Fixture = body.CreateFixture(fd);
			
			return fixture;
		}
	}
}