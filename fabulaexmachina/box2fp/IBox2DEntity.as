package fabulaexmachina.box2fp 
{
	
	/**
	 * ...
	 * @author Paul Sztajer
	 */
	public interface IBox2DEntity 
	{
		function get X():Number;
		function set X(v:Number):void;
		function get Y():Number;
		function set Y(v:Number):void;
		function get Width():Number;
		function set Width(v:Number):void;
		function get Height():Number;
		function set Height(v:Number):void;
		
		function collidePoint(x:Number, y:Number, pX:Number, pY:Number):Boolean;
	}
	
}