state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
    // Time Trial 
    int checkpoint: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int totalCheckpoints: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
    byte activeTTStretch: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3F9;
    float finishedTime: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x424;
    
    // Qualifying Times
    float star_3: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x408;
    float star_2: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Origin") 
{
    int checkpoint: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D4;
    int totalCheckpoints: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D0;
    byte activeTTStretch: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3F9;
    float finishedTime: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x424;
    
    float star_3: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x408;
    float star_2: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Reloaded") 
{
    int checkpoint: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D4;
    int totalCheckpoints: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D0;
    byte activeTTStretch: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3F9;
    float finishedTime: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x424;
    
    float star_3: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x408;
    float star_2: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Origin (Asia)") 
{
    int checkpoint: 0x01BE6134, 0x50, 0x1E0, 0x318, 0x3D4;
    int totalCheckpoints: 0x01BE6134, 0x50, 0x1E0, 0x318, 0x3D0;
    byte activeTTStretch: 0x01BE6134, 0x50, 0x1E0, 0x318, 0x3F9;
    float finishedTime: 0x01BE6134, 0x50, 0x1E0, 0x318, 0x424;
    
    float star_3: 0x01BE6134, 0x50, 0x1E0, 0x318, 0x408;
    float star_2: 0x01BE6134, 0x50, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01BE6134, 0x50, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Origin (DLC)") 
{
    int checkpoint: 0x01C1BE24, 0x50, 0x1E0, 0x318, 0x3D4;
    int totalCheckpoints: 0x01C1BE24, 0x50, 0x1E0, 0x318, 0x3D0;
    byte activeTTStretch: 0x01C1BE24, 0x50, 0x1E0, 0x318, 0x3F9;
    float finishedTime: 0x01C1BE24, 0x50, 0x1E0, 0x318, 0x424;
    
    float star_3: 0x01C1BE24, 0x50, 0x1E0, 0x318, 0x408;
    float star_2: 0x01C1BE24, 0x50, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01C1BE24, 0x50, 0x1E0, 0x318, 0x410;
}

init 
{
    switch (modules.First().ModuleMemorySize) 
    {
        case 32976896: 
        case 32632832: 
            version = "Steam"; 
            break;
    
        case 42889216: 
            version = "Origin"; 
            break;
    
        case 60298504: 
        case 42876928: 
            version = "Reloaded"; 
            break;
    
        case 42717184:
            version = "Origin (Asia)";
            break;

        case 43794432:
            version = "Origin (DLC)";
            break;

        default: 
            MessageBox.Show("Memory Size: " + modules.First().ModuleMemorySize.ToString(), "Unknown Version Detected!");
            version = "Unknown"; 
            break;
    }
}

startup
{
    settings.Add("StarRequirement", true, "Star Requirement");
    settings.Add("3Star", true, "3 Stars", "StarRequirement");
    settings.Add("2Star", false, "2 Stars", "StarRequirement");
    settings.Add("1Star", false, "1 Star", "StarRequirement");
}

start 
{
    return current.activeTTStretch == 15 && old.activeTTStretch == 0;
}

split 
{
    if (current.checkpoint > old.checkpoint) 
    {
        if (current.checkpoint == current.totalCheckpoints) 
        {
            if (settings["StarRequirement"] == false) 
            {
                return true;
            }

            if (settings["3Star"] == true) 
            {
                return current.star_3 > Math.Round(current.finishedTime, 2);
            }

            if (settings["2Star"] == true) 
            {
                return current.star_2 > Math.Round(current.finishedTime, 2);
            }

            if (settings["1Star"] == true) 
            {
                return current.star_1 > Math.Round(current.finishedTime, 2);
            }
        }
    } 
}

exit
{
    timer.IsGameTimePaused = true;
}