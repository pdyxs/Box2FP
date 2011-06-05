package net.box2fp.graphics
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	/**
	 * A type of Graphiclist that can update certain characteristics
	 * 		of all of its children.
	 * 		Where possible, when attributes are set they are altered relative
	 * 		to the child's curent value of that attribute.
	 * @author Paul Sztajer
	 */
	public class SuperGraphiclist extends Graphiclist
	{
		public function SuperGraphiclist(...graphic)
		{
			super();
			for each (var g:Graphic in graphic) add(g);
		}
		
		/**
		 * Get the scale of the graphiclist
		 */
		public function get scale():Number { return _scale; }
		/**
		 * Set the scale. Multiplies with the current scale of children
		 */
		public function set scale(v:Number):void
		{
			if (_scale == v) return; 
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).scale *= v/_scale;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).scale *= v/_scale;
			}
			_scale = v;
		}
		/** @private */ private var _scale:Number = 1;
		
		/**
		 * Get the scaleX of the graphiclist
		 */
		public function get scaleX():Number { return _scaleX; }
		/**
		 * Set the x scale. Multiplies with the current scaleX of children
		 */
		public function set scaleX(v:Number):void
		{
			if (_scaleX == v) return;
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).scaleX *= v/_scaleX;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).scaleX *= v/_scaleX;
			}
			_scaleX = v;
		}
		/** @private */ private var _scaleX:Number = 1;
		
		/**
		 * Get the scaleY of the graphiclist
		 */
		public function get scaleY():Number { return _scaleY; }
		/**
		 * Set the y scale. Multiplies with the current scaleY of children
		 */
		public function set scaleY(v:Number):void
		{
			if (_scaleY == v) return;
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).scaleY *= v/_scaleY;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).scaleY *= v/_scaleY;
			}
			_scaleY = v;
		}
		/** @private */ private var _scaleY:Number = 1;
		
		/**
		 * Get the angle of the graphiclist
		 */
		public function get angle():Number { return _angle; }
		/**
		 * Set the angle. Adds to the current angle of children
		 */
		public function set angle(v:Number):void
		{
			if (_angle == v) return;
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).angle += v - _angle;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).angle += v - _angle;
			}
			_angle = v;
		}
		/** @private */ private var _angle:Number = 0;
		
		/**
		 * Get the color of the graphiclist
		 */
		public function get color():uint { return _color; }
		/**
		 * Set the color of all children.
		 */
		public function set color(v:uint):void
		{
			if (_color == v) return;
			_color = v;
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).color = v;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).color = v;
				else if (g is Canvas)
					(g as Canvas).color = v;
			}
		}
		/** @private */ private var _color:uint = 0xFFFFFF;
		
		/**
		 * Get the blend mode of the graphiclist
		 */
		public function get blend():String { return _blend; }
		/**
		 * Set the blend mode of all children
		 */
		public function set blend(v:String):void
		{
			if (_blend == v) return;
			_blend = v;
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).blend = v;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).blend = v;
				else if (g is Canvas)
					(g as Canvas).blend = v;
			}
		}
		/** @private */ private var _blend:String = "multiply";
		
		/**
		 * Get the alpha of the graphiclist
		 */
		public function get alpha():Number { return _alpha; }
		/**
		 * Set the alpha. Multiplies with the current angle of children
		 */
		public function set alpha(v:Number):void
		{
			if (_alpha == v) return;
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).alpha *= v/_alpha;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).alpha *= v/_alpha;
				else if (g is Canvas)
					(g as Canvas).alpha *= v/_alpha;
			}
			_alpha = v;
		}
		/** @private */ private var _alpha:Number = 1;
		
		/**
		 * Get the smooth attribute of the graphiclist
		 */
		public function get smooth():Boolean { return _smooth; }
		/**
		 * Set the smooth attribute for all children
		 */
		public function set smooth(v:Boolean):void
		{
			_smooth = v;
			for each (var g:Graphic in children)
			{
				if (g is Image)
					(g as Image).smooth = !(g as Image).smooth;
				else if (g is SuperGraphiclist)
					(g as SuperGraphiclist).smooth = !(g as SuperGraphiclist).smooth;
			}
		}
		/** @private */ private var _smooth:Boolean = false;
		
		/**
		 * Get the flipped attribute of the graphiclist
		 */
		public function get flipped():Boolean { return _flipped; }
		/**
		 * Set the flipped attribute. Swaps the flipped state of children if it flips
		 */
		public function set flipped(v:Boolean):void
		{
			if (_flipped != v)
			{	
				_flipped = v;
				for each (var g:Graphic in children)
				{
					if (g is Image)
						(g as Image).flipped = !(g as Image).flipped;
					else if (g is SuperGraphiclist)
						(g as SuperGraphiclist).flipped = !(g as SuperGraphiclist).flipped;
				}
			}
		}
		/** @private */ private var _flipped:Boolean = false;
	}
}