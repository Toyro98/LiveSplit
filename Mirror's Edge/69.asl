/* 
* Autosplitter for the game Mirror's Edge for the category "69 Stars"
* Made by: Toyro98
* 
* If you want to start on another time trial rather than Playground One
* Go to line 120 and change the 15 to one of these belows  
*
* 15    Playground One
* 16    Playground Two
* 21    Playground Three
* 4     Edge
* 23    Arland
* 22    Flight
* 6     Chase
* 7     Stormdrains One
* 8     Stormdrains Two
* 9     Stormdrains Three
* 20    Burfield
* 1     Heat
* 3     Cranes One
* 2     Cranes Two
* 14    New Eden
* 17    Factory
* 24    Office
* 12    Convoy One
* 13    Convoy Two
* 10    Atrium One
* 11    Atrium Two
* 18    Shard One
* 19    Shard Two
*/

state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
    // Time Trial 
    int totalCheckpoints: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
    int currentCheckpoint: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    byte activeTTStretch: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3F9;
    float timeFinishedAt: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x424;
    
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
    float timeFinishedAt: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x424;
    
    float star_3: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x408;
    float star_2: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "GoG") 
{
    int totalCheckpoints: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
    int currentCheckpoint: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    byte activeTTStretch: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3F9;
    float timeFinishedAt: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x424;
    
    float star_3: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x408;
    float star_2: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x40C;
    float star_1: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x410;
}

state ("MirrorsEdge", "Reloaded") 
{
    int totalCheckpoints: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D0;
    int currentCheckpoint: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D4;
    byte activeTTStretch: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3F9;
    float timeFinishedAt: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x424;
    
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
                return current.star_3 > Math.Round(current.timeFinishedAt, 2);
            }
            
            return true;
        }
    } 
}

exit
{
    timer.IsGameTimePaused = true;
}
