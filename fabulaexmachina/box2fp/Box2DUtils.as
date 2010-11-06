package fabulaexmachina.box2fp
{
	import Box2D.Common.Math.b2Vec2;

	public class Box2DUtils
	{
		public static function convertToBoxCoords(p:b2Vec2, w:Number, h:Number, 
												  scale:Number):b2Vec2
		{
			var ret:b2Vec2 = p.Copy();
			ret.Add(new b2Vec2(w/2, h/2));
			ret.Multiply(1.0 / scale);
			return ret;
		}
	}
}