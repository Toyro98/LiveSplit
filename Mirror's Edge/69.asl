// Autosplitter for the game Mirror's Edge for the category "69 Stars"
// Made by: Toyro98

state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
	// Time Trial 
	int totalCheckpoints: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
	int currentCheckpoint: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
	byte activeTTStretch: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3F9;
	
	// Qualifying Times
	float star_3: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x408;
	float star_2: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x40C;
	float star_1: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Origin") 
{
	int totalCheckpoints: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D0;
	int currentCheckpoint: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D4;
	byte activeTTStretch: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3F9;
	
	float star_3: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x408;
	float star_2: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x40C;
	float star_1: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "GoG") 
{
	int totalCheckpoints: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
	int currentCheckpoint: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
	byte activeTTStretch: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3F9;
	
	float star_3: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x408;
	float star_2: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x40C;
	float star_1: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Reloaded") 
{
	int totalCheckpoints: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D0;
	int currentCheckpoint: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D4;
	byte activeTTStretch: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3F9;
	
	float star_3: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x408;
	float star_2: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x40C;
	float star_1: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x410;
}

startup
{
	settings.Add("3Star", true, "3 Star Requirement");
	settings.SetToolTip("3Star", "If true, only split when you beat 3 stars on a time trial. Otherwise, it ignores the star requirement and splits when you finish a time trial");
}

init 
{
	switch (modules.First().ModuleMemorySize.ToString()) 
	{
		case "32976896": 
			version = "Steam"; 
			break;
	
		case "42889216": 
			version = "Origin"; 
			break;
	
		case "32632832": 
			version = "GoG"; 
			break;
	
		case "60298504": 
			version = "Reloaded"; 
			break;
	
		default: 
			MessageBox.Show("It appears you're running an unknown version of the game :(\nIf you're not running on Steam, Origin, GoG, or Reloaded. Please contact Toyro98#0001 on Discord for help!\n\nMemory Size: " + modules.First().ModuleMemorySize.ToString(), "Unknown Version Detected!");
			version = "Unknown"; 
			break;
	}
}

start 
{
	if (current.activeTTStretch == 15 && old.activeTTStretch == 0)
	{
		return true;
	}
}

split 
{
	if (current.currentCheckpoint > old.currentCheckpoint) 
	{
		if (current.currentCheckpoint == current.totalCheckpoints) 
		{
			if (settings["3Star"] == true) 
			{
				if (current.star_3 > Math.Round(current.timeFinishedAt, 2)) 
				{
					return true;
				}
				
				return false;
			} 
			
			return true;
		}
	} 
}

exit
{
	timer.IsGameTimePaused = true;
}
