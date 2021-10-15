// Autosplitter for the game Mirror's Edge for the category "69 Stars"
// Made by: Toyro98

state ("MirrorsEdge", "Unknown Version") {}

state ("MirrorsEdge", "Steam") 
{
    // Prevent it from automatically starting if you closed the game and timer isn't running (Thank you tdog20)
	bool loading: 0x1BFA620;

    // Time Trial 
    int totalCheckpoints: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
    int currentCheckpoint: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int currentTimeTrialID: 0x01C55EA8, 0x170, 0x74, 0xC, 0xFC;
    float timeFinishedAt: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x424;

    // Player's x position
    float playerX: 0x01C553D0, 0xCC, 0x1CC, 0xD0, 0x10, 0xE8;

    // Qualifying times
    float star_3: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x408;
    float star_2: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Origin") 
{
    bool loading: 0x1C19AB0;

    int totalCheckpoints: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D0;
    int currentCheckpoint: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D4;
    int currentTimeTrialID: 0x01C6EFE0, 0x1A0, 0x74, 0xC, 0xFC;
    float timeFinishedAt: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x424;

    float playerX: 0x01B7C39C, 0xCC, 0x70, 0x2F8, 0xE8; 

    float star_3: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x408;
    float star_2: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "GoG") 
{
	bool loading: 0x1BFA620;

    int totalCheckpoints: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
    int currentCheckpoint: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int currentTimeTrialID: 0x01C55EA8, 0x170, 0x74, 0xC, 0xFC;
    float timeFinishedAt: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x424;

    float playerX: 0x01C553D0, 0xCC, 0x1CC, 0xD0, 0x10, 0xE8;

    float star_3: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x408;
    float star_2: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Reloaded") 
{
    bool loading: 0x1C136D4;

    int totalCheckpoints: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D0;
    int currentCheckpoint: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D4;
    int currentTimeTrialID: 0x01C60078, 0x2E0, 0x1CC, 0x418;
    float timeFinishedAt: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x424;

    float playerX: 0x01B7C39C, 0xCC, 0x70, 0x1C0, 0xE8;

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
            version = "Unknown Version"; 
            break;
    }
}

start 
{
    if (current.currentTimeTrialID == 0 && current.playerX != -79.89811f)
    {
        if (old.playerX == -79.89811f && old.loading == false && current.loading == true)
        {
            return true;
        }
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
                else 
                {
                    return false;
                }
            } 
            return true;
        }
    } 
}

exit
{
    timer.IsGameTimePaused = true;
}
