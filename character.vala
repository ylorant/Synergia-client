using SDL;
using SDLGraphics;
using Stk;

namespace Synergia
{
	public enum Orientation
	{
		NORTH = 3, SOUTH = 0, EAST = 2, WEST = 1
	}
	
	public class Character : Widget
	{
		protected Surface sprite;
		protected Surface nameSurface;
		public Orientation orientation;
		protected int frame;
		public Rect pos;
		public Rect offset;
		public int id;
		public int16 motion = 0;
		public string name;
		public int16 move_offset = 0;
		public Orientation move_orientation;
		
		public Character(NetConnector net)
		{
			this.pos = Rect();
			this.offset = Rect();
			this.orientation = Orientation.SOUTH;
			this.frame = 0;
			this.sprite = SDLImage.load("gfx/charsets/player.png");
			this.sprite.set_alpha(0, 0);
			
			net.events.position.connect(this.ChangePosition);
			net.events.moveleft.connect(this.MoveLeft);
			net.events.moveup.connect(this.MoveUp);
			net.events.moveright.connect(this.MoveRight);
			net.events.movedown.connect(this.MoveDown);
		}
		
		public void MoveLeft(string[] command)
		{
			if(this.id == int.parse(command[0]))
			{
				this.pos.x--;
				this.orientation = Orientation.WEST;
				this.motion = 32;
			}
		}
		
		public void MoveRight(string[] command)
		{
			if(this.id == int.parse(command[0]))
			{
				this.pos.x++;
				this.orientation = Orientation.EAST;
				this.motion = 32;
			}
		}
		public void MoveUp(string[] command)
		{
			if(this.id == int.parse(command[0]))
			{
				this.pos.y--;
				this.orientation = Orientation.NORTH;
				this.motion = 32;
			}
		}
		public void MoveDown(string[] command)
		{
			if(this.id == int.parse(command[0]))
			{
				this.pos.y++;
				this.orientation = Orientation.SOUTH;
				this.motion = 32;
			}
		}
		
		public void ChangePosition(string[] command)
		{
			if(this.id == int.parse(command[0]))
			{
				this.pos.x = (int16)int.parse(command[1]);
				this.pos.y = (int16)int.parse(command[2]);
				this.motion = 0;
			}
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
			
			if(this.move_offset != 0)
			{
				switch(this.move_orientation)
				{
					case Orientation.NORTH:
						dst.y -= this.move_offset;
						break;
					case Orientation.SOUTH:
						dst.y += this.move_offset;
						break;
					case Orientation.EAST:
						dst.x += this.move_offset;
						break;
					case Orientation.WEST:
						dst.x -= this.move_offset;
						break;
				}
			}
			
			if(this.motion != 0)
			{
				switch(this.orientation)
				{
					case Orientation.NORTH:
						dst.y += this.motion;
						break;
					case Orientation.SOUTH:
						dst.y -= this.motion;
						break;
					case Orientation.EAST:
						dst.x -= this.motion;
						break;
					case Orientation.WEST:
						dst.x += this.motion;
						break;
				}
			}
			
			if(dst.x < -31 || dst.x > screen.w + 31 || dst.y < -31 || dst.y > screen.h + 31)
				return true;
			
			if(this.nameSurface == null)
			{
				this.nameSurface = Stk.Stk.font.render_blended(this.name, {255, 255, 255, 255});
				this.nameSurface.set_alpha(0, 0);
			}
			
			this.sprite.blit(src, screen, dst);
			dst.y -= (int16)this.nameSurface.h;
			this.nameSurface.blit(null, screen, dst);
			dst.y += (int16)this.nameSurface.h;
			
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
