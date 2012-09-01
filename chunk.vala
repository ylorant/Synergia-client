using SDL;
using SDLGraphics;
using Stk;

namespace Synergia
{
	public class Chunk
	{
		public Tile[] data;
		public int x;
		public int y;
		
		public Chunk(int x, int y, Tile[] data)
		{
			this.data = data;
			this.x = x;
			this.y = y;
		}
	}
}
