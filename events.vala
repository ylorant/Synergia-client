namespace Synergia
{
	public class Events
	{
		//Events
		public signal void ping(string[] args);
		public signal void connect(string[] args);
		public signal void not_found(string[] args);
		public signal void player_character(string[] args);
		public signal void change_tileset(string[] args);
		public signal void character_out(string[] args);
		public signal void position(string[] args);
		public signal void character(string[] args);
		public signal void chunk(string[] args);
		public signal void moveleft(string[] args);
		public signal void moveup(string[] args);
		public signal void moveright(string[] args);
		public signal void movedown(string[] args);
		
		//Error event
		public signal void error(int errnum, string errstr);
		
		//Raises an event from its name
		public void raise(string eventName, string[] command)
		{
			switch(eventName)
			{
			
				case "ping": this.ping(command); break;
				case "connect": this.connect(command); break;
				case "error": this.error(int.parse(command[0]), command[1]); break;
				case "player-character": this.player_character(command); break;
				case "change-tileset": this.change_tileset(command); break;
				case "position": this.position(command); break;
				case "character": this.character(command); break;
				case "character-out": this.character_out(command); break;
				case "chunk": this.chunk(command); break;
				case "moveleft": this.moveleft(command); break;
				case "moveup": this.moveup(command); break;
				case "moveright": this.moveright(command); break;
				case "movedown": this.movedown(command); break;
				default: this.not_found({ eventName }); break;
			}
		}
	}
}
