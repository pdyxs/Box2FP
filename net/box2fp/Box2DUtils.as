package net.box2fp
{
	import Box2D.Common.Math.b2Vec2;

	/**
	 * Utility class
	 */
	public class Box2DUtils
	{
		/**
		 * Convert Flashpunk to Box2d Coordinates.
		 * Note that flashpunk co-ordinates are from top-left, and Box2D
		 * 	coordinates are from the centre.
		 * @param p			The position (in pixels)
		 * @param w			The height (in pixels)
		 * @param h			The width (in pixels)
		 * @param scale		The world scale
		 * @return			The position (in metres)
		 */
		public static function FP2BoxCoords(p:b2Vec2, w:Number, h:Number, 
												  scale:Number):b2Vec2
		{
			var ret:b2Vec2 = p.Copy();
			ret.Add(new b2Vec2(w/2, h/2));
			ret.Multiply(1.0 / scale);
			return ret;
		}
		
		/**
		 * Convert Box2d to Flashpunk Coordinates.
		 * Note that flashpunk co-ordinates are from top-left, and Box2D
		 * 	coordinates are from the centre.
		 * @param p			The position (in metres)
		 * @param w			The height (in pixels)
		 * @param h			The width (in pixels)
		 * @param scale		The world scale
		 * @return			The position (in pixels)
		 */
		public static function Box2FPCoords(p:b2Vec2, w:Number, h:Number, 
											scale:Number):b2Vec2
		{
			var ret:b2Vec2 = p.Copy();
			ret.Multiply(scale);
			ret.Subtract(new b2Vec2(w/2, h/2));
			return ret;
		}
	}
}