package net.box2fp 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	
	/**
	 * An interface for a Box2DEntity for later use.
	 * Note that this doesn't include Entity functions such as 'moveTo' 
	 * 		or 'clampHorizontal' as they don't mix well with Box2DEntities
	 * 		right now (TODO!)
	 * @author Paul Sztajer
	 */
	public interface IBox2DEntity 
	{
		//getters for simple Entity variables
		function get X():Number;
		function set X(v:Number):void;
		function get Y():Number;
		function set Y(v:Number):void;
		function get Width():Number;
		function set Width(v:Number):void;
		function get Height():Number;
		function set Height(v:Number):void;
		
		//Entity hooks
		function added():void;
		function removed():void;
		function update():void;
		function render():void;
		
		//Entity Collisions
		function collide(type:String, x:Number, y:Number):Entity;
		function collideTypes(types:Object, x:Number, y:Number):Entity;
		function collideWith(e:Entity, x:Number, y:Number):Entity;
		function collideRect(x:Number, y:Number, rX:Number, rY:Number, rWidth:Number, rHeight:Number):Boolean;
		function collidePoint(x:Number, y:Number, pX:Number, pY:Number):Boolean;
		function collideInto(type:String, x:Number, y:Number, array:Object):void;
		function collideTypesInto(types:Object, x:Number, y:Number, array:Object):void;
			
		//Entity getters
		function get onCamera():Boolean;
		function get world():World;
		function get halfWidth():Number;
		function get halfHeight():Number;
		function get centerX():Number; 
		function get centerY():Number;
		function get left():Number;
		function get right():Number;
		function get top():Number;
		function get bottom():Number;
		
		//Layers and Types
		function get layer():int;
		function set layer(value:int):void;
		function get type():String;
		function set type(value:String):void;
		
		//Masks and Graphics
		function get mask():Mask;
		function set mask(value:Mask):void;
		function get graphic():Graphic;
		function set graphic(value:Graphic):void;
		function addGraphic(g:Graphic):Graphic;
		function setHitbox(width:int = 0, height:int = 0, originX:int = 0, originY:int = 0):void;
		function setHitboxTo(o:Object):void;
		function setOrigin(x:int = 0, y:int = 0):void;
		function centerOrigin():void;
		
		//Distances
		function distanceFrom(e:Entity, useHitboxes:Boolean = false):Number;
		function distanceToPoint(px:Number, py:Number, useHitbox:Boolean = false):Number;
		function distanceToRect(rx:Number, ry:Number, rwidth:Number, rheight:Number):Number;
		
		
	}
	
}