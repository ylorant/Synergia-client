using SDL;
using SDLGraphics;
using Stk;
using Gee;

namespace Synergia
{
	public class Map : Widget
	{
		private Gee.List<Chunk> chunks;
		private Surface tileset;
		private Player player;
		private Rect offset;
		private Gee.List<Character> characters;
		
		public Map(NetConnector net, Player p, Gee.List<Character> characters)
		{
			this.player = p;
			this.offset = Rect();
			this.player.offset = this.offset;
			this.chunks = new ArrayList<Chunk>();
			this.characters = characters;	
			net.events.chunk.connect(this.UpdateChunk);
			net.events.change_tileset.connect(this.ChangeTileset);
		}
		
		public void ChangeTileset(string[] command)
		{
			this.tileset = SDLImage.load("gfx/tilesets/"+command[0]+".png");
			this.tileset.set_alpha(0, 0);
		}
		
		public void UpdateChunk(string[] command)
		{
			int x = int.parse(command[0]);
			int y = int.parse(command[1]);
			
			foreach(Chunk c in this.chunks)
			{
				if(c.x == x && c.y == y)
				{
					this.chunks.remove(c);
					break;
				}
			}
			
			Tile[] data = new Tile[16];
			
			for(int i = 0; i < 16; i++)
			{
				if(command[i+2] != null)
				{
					string[] tileinfo = command[i+2].split("/", 2);
					data[i] = Tile();
					data[i].set = true;
					data[i].value = tileinfo[0];
					data[i].crossable = (tileinfo[1] == "1" ? true : false);
				}
				else
				{
					data[i] = Tile();
					data[i].set = false;
				}
			}
			
			Chunk c = new Chunk(x, y, data);
			this.chunks.add(c);
		}
		
		public override bool draw(Surface screen)
		{
			base.draw(screen);
			int tileint,row, col;
			SDL.Rect src, dst;
			
			if(this.chunks.size == 0 || this.tileset == null)
				return true;
			
			src = SDL.Rect();
			dst = SDL.Rect();
			
			dst.w = 32;
			dst.h = 32;
			
			src.w = 32;
			src.h = 32;
			
			this.offset.x = this.player.pos.x - 9;
			this.offset.y = this.player.pos.y - 7;
			this.player.offset = this.offset;
			
			foreach(Character c in this.characters)
			{
				c.offset = this.offset;
				c.move_offset = this.player.motion;
				c.move_orientation = this.player.orientation;
			}
			
			foreach(Chunk c in this.chunks)
			{
				int dx = 0, dy = 0;
				foreach(Tile t in c.data)
				{
					if(t.set != false)
					{
						dst.x = (int16)(c.x + dx - this.offset.x);
						dst.y = (int16)(c.y + dy - this.offset.y);
						tileint = int.parse(t.value);
						row = tileint / 8;
						col = tileint - (row * 8);
						src.x = 32 * col;
						src.y = 32 * row;
						
						dst.x *= 32;
						dst.y *= 32;
						
						if(this.player.motion != 0)
						{
							switch(this.player.orientation)
							{
								case Orientation.NORTH:
									dst.y -= this.player.motion;
									break;
								case Orientation.SOUTH:
									dst.y += this.player.motion;
									break;
								case Orientation.EAST:
									dst.x += this.player.motion;
									break;
								case Orientation.WEST:
									dst.x -= this.player.motion;
									break;
							}
						}
						
						if(dst.x >= -31 && dst.x <= screen.w + 31 && dst.y >= -31 && dst.y <= screen.h + 31)
							this.tileset.blit(src, screen, dst);
						
						dx++;
						if(dx == 4)
						{
							dx = 0;
							dy++;
						}
					}
				}
			}
			
			return true;
		}
	}
}
