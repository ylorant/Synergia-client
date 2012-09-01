using SDL;
using SDLGraphics;
using Stk;

namespace Synergia
{
	public class Player : Character
	{
		private NetConnector net;
		
		public Player(NetConnector net)
		{
			base(net);
			this.net = net;
			
			net.events.player_character.connect(this.PlayerCharacterEvent);
			Stk.Stk.events.keydown.connect(this.OnKeydown);
		}
		
		public void OnKeydown(KeyboardEvent e)
		{
			if(this.motion != 0)
				return;
			switch(e.keysym.sym)
			{
				case KeySymbol.UP:
					this.pos.y--;
					this.orientation = Orientation.NORTH;
					this.net.send_direct("moveup");
					break;
				case KeySymbol.DOWN:
					this.pos.y++;
					this.orientation = Orientation.SOUTH;
					this.net.send_direct("movedown");
					break;
				case KeySymbol.LEFT:
					this.pos.x--;
					this.orientation = Orientation.WEST;
					this.net.send_direct("moveleft");
					break;
				case KeySymbol.RIGHT:
					this.pos.x++;
					this.orientation = Orientation.EAST;
					this.net.send_direct("moveright");
					break;
				default:
					return;
			}
			this.motion = 32;
		}
		
		public void PlayerCharacterEvent(string[] command)
		{
			this.name = command[1];
			this.id = int.parse(command[0]);
			Stk.Stk.clear_windows();
			this.net.send_direct("get-position");
			this.net.send_direct("getmap");
		}
		
		public override bool draw(Surface screen)
		{
			Rect src = Rect();
			Rect dst = Rect();
			
			src.w = 32;
			src.h = 32;
			dst.w = 32;
			dst.h = 32;
			
			if(this.motion > 0)
				this.frame = (Stk.Stk.ticks / 8) % 4;
			else if((Stk.Stk.ticks / 8) % 4 != ((Stk.Stk.ticks -1 )/ 8) % 4)
				this.frame = 0;
			
			src.x = 32 * this.frame;
			src.y = 32 * this.orientation;
			
			dst.x = 32 * (this.pos.x - this.offset.x);
			dst.y = 32 * (this.pos.y - this.offset.y);
			
			this.sprite.blit(src, screen, dst);
			
			if(this.motion > 0)
				this.motion--;
			
			this.rect.x = dst.x;
			this.rect.y = dst.y;
			this.rect.w = 32;
			this.rect.h = 32;
			return true;
		}
	}
}
